![Codeship Status for semlogr/semlogr](https://codeship.com/projects/b5709d40-3693-0134-2dce-36dc468776c7/status?branch=master)

# Semlogr

Semlogr is a semantic logger for Ruby inspired and primarily ported from the awesome semantic logger for .NET [Serilog](http://serilog.net/).

## Installation

To install:

    gem install semlogr

Or if using bundler, add semlogr to your Gemfile:

    gem 'semlogr'

then:

    bundle install

## Getting Started

Create an instance of the logger configuring one or more sinks. 

```ruby
require "semlogr"

Semlogr.logger = Semlogr.create_logger do |c|
  c.log_at :info

  c.write_to :colored_console
end

Semlogr.info('Customer {customer_id} did something interesting', customer_id: 1234)
```

More configuration examples can be found inside the samples directory.

## Development

After cloning the repository run `bundle install` to get up and running, to run the specs just run `bundle exec rake`. You can also experiment in an interactive pry console using `bin/console`.

## Contributing

See anything broken or something you would like to improve? feel free to submit an issue or better yet a pull request!
