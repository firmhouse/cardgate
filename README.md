# Cardgate

This gem is a client for the Cardgate REST API.

## Installation

Add this line to your application's Gemfile:

    gem 'cardgate'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cardgate

## Usage

To configure this gem on rails, add the following initializer.

```ruby
unless Rails.env.production?
  Cardgate::Gateway.environment = :test
end

Cardgate::Gateway.merchant = ''
Cardgate::Gateway.api_key = ''
Cardgate::Gateway.request_logger = true # or false if you want to disable request logging
```

## Contributing

1. Fork it ( http://github.com/yourivdlans/cardgate/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
