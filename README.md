# Big Book Hunter

Welcome to the "Big Book Hunter" gem! This CLI app scrapes the popular used and rare books marketplace, AbeBooks.com, for new listings of rare books priced above $10,000 to help you stay on top of notable new books and documents on the market. (It also screens out sellers who frequently post spam listings or unrelated material, in order to make this a more useful tool for the true hunter!)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bigbookhunter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bigbookhunter

## Usage

Run `bin/bigbookhunter` after installing the gem.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/bigbookhunter.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
