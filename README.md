# wesender-ruby

Officiële Ruby SDK voor de [WeSender](https://wesender.nl) e-mail API.

## Installatie

```bash
gem install wesender
```

Of via Gemfile:

```ruby
gem 'wesender'
```

## Gebruik

```ruby
require 'wesender'

ws = Wesender::Client.new(ENV['WS_API_KEY'])

# E-mail versturen
result = ws.emails.send(
  from:    'noreply@joudomein.nl',
  to:      'klant@voorbeeld.nl',
  subject: 'Welkom!',
  html:    '<h1>Hallo!</h1>'
)
puts result[:id]

# Domeinen bekijken
domains = ws.domains.list
puts domains.map { |d| d[:domain] }
```

## Vereisten

Ruby 2.7+

## Links

- [Documentatie](https://wesender.nl/docs/sdks/ruby)
- [Issues](https://github.com/nljerry/wesender-ruby/issues)
