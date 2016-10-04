![Codeship Status for semlogr/semlogr](https://codeship.com/projects/b5709d40-3693-0134-2dce-36dc468776c7/status?branch=master)

# Semlogr

Semlogr is a semantic logger for Ruby inspired by the amazing semantic logger for .NET [Serilog](http://serilog.net/).

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
require "semlogr/sinks/colored_console"

logger = Semlogr::Logger.create do |c|
  c.min_level(Semlogr::LogLevel::INFO)

  c.write_to(Semlogr::Sinks::ColoredConsole.new)
end

logger.info('Customer {customer_id} did something interesting', customer_id: 1234)
```

## Development

After cloning the repository run `bundle install` to get up and running, to run the specs just run `rake spec`. You can also experiment in an interactive pry console using `bin/console`.

## Changes

### 0.1.0

  - Initial commit, long long way to go :)!

## Contributing

See anything broken or something you would like to improve? feel free to submit an issue or better yet a pull request!
