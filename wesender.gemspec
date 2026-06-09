Gem::Specification.new do |s|
  s.name        = "wesender"
  s.version     = "1.0.0"
  s.summary     = "Officiële Ruby SDK voor de WeSender e-mail API"
  s.description = "Verstuur transactionele e-mails via de WeSender API."
  s.authors     = ["WeSender"]
  s.email       = "support@wesender.nl"
  s.homepage    = "https://wesender.nl"
  s.license     = "MIT"

  s.files       = Dir["lib/**/*.rb", "README.md", "LICENSE"]
  s.require_paths = ["lib"]

  s.required_ruby_version = ">= 2.7.0"
end
