require "net/http"
require "json"
require "uri"

module Wesender
  VERSION  = "1.0.0"
  BASE_URL = "https://api.wesender.nl"

  class Error < StandardError
    attr_reader :status
    def initialize(message, status = 0)
      super(message)
      @status = status
    end
  end

  class Client
    def initialize(api_key, base_url: BASE_URL)
      raise ArgumentError, "api_key is verplicht" if api_key.nil? || api_key.empty?
      @api_key  = api_key
      @base_url = base_url
    end

    def emails = Emails.new(self)
    def domains = Domains.new(self)

    def get(path)    = request("GET",    path)
    def post(path, body) = request("POST",   path, body)
    def delete(path) = request("DELETE", path)

    private

    def request(method, path, body = nil)
      uri  = URI(@base_url + path)
      http = Net::HTTP.new(uri.host, uri.port).tap { |h| h.use_ssl = true }
      req  = Net::HTTP.const_get(method.capitalize).new(uri)
      req["Authorization"] = "Bearer #{@api_key}"
      req["Content-Type"]  = "application/json"
      req["User-Agent"]    = "wesender-ruby/#{VERSION}"
      req.body = body.to_json if body
      res = http.request(req)
      data = JSON.parse(res.body, symbolize_names: true)
      raise Error.new(data[:error] || "HTTP #{res.code}", res.code.to_i) unless res.is_a?(Net::HTTPSuccess)
      data
    end
  end

  class Emails
    def initialize(client) = @c = client
    def send(**params)     = @c.post("/emails", params)
    def list(limit: 50)   = @c.get("/emails?limit=#{limit}")[:data]
    def get(id)            = @c.get("/emails/#{id}")
  end

  class Domains
    def initialize(client)       = @c = client
    def list                     = @c.get("/domains")[:data]
    def create(domain)           = @c.post("/domains", { domain: })
    def delete(id)               = @c.delete("/domains/#{id}")
  end
end
