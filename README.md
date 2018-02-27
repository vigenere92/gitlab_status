gitlab_status is a Ruby cli to check the average response time of https://www.gitlab.com spread over 10s for 1 minute.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gitlab_status'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gitlab_status

## Usage
You can use gitlab_status with -v, --verbose to get individual response times for each request as well.
```
gitlab_status -v
```

Or you can use gitlab_status without any flag to get only the average response time.
```
gitlab_status
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/vigenere92/gitlab_status. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

