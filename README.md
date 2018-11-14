# Rickai

Gem which will help you to get integration with Rick.io the fastest way

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rickai'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rickai

## Usage

For creating of instance you need to call 

```ruby
client = Rickai::Client.new(agent_url)
```

For calling action of update you just can call
```ruby
client.update(your_attributes)
```

For calling action of create you just can call
```ruby
client.create(your_attributes)
```

For calling action of check you just can call
```ruby
client.check(your_attributes)
```

## Contributing

1. Fork it
2. Clone your fork (git clone git@github.com:MY_USERNAME/customerio-ruby.git && cd customerio-ruby)
3. Create your feature branch (git checkout -b my-new-feature)
4. Commit your changes (git commit -am 'Added some feature')
5. Push to the branch (git push origin my-new-feature)
6. Create new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
