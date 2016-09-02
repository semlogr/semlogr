require "bundler/setup"
require "semlogr"
require "semlogr/sinks/console"
require "semlogr/sinks/colored_console"
require "semlogr/sinks/file"
require 'semlogr/formatters/json_formatter'

logger = Semlogr::Logger.create do |c|
  c.min_level Semlogr::LogLevel::DEBUG

  c.write_to Semlogr::Sinks::Console.new
  c.write_to Semlogr::Sinks::ColoredConsole.new
  c.write_to Semlogr::Sinks::Console.new(formatter: Semlogr::Formatters::JsonFormatter.new)
end

logger.debug('Test {id}, string {string}')
logger.debug('Test {id}, string {string}', id: 1234, string: "foo")
logger.info('Test {id}, string {string}', id: 1234, string: "foo")
logger.warn('Test {id}, string {string}', id: 1234, string: "foo")
logger.fatal('Test {id}, string {string}', id: 1234, string: "foo")
logger.fatal('Test array {array}', array: [1,2,3, "foo"])

logger.debug {
  'Testing with a block'
}

logger.debug {
  ['Testing with a block, id: {id}', id: 1234]
}

logger.error('ERROR!!!', error: StandardError.new('test'))
logger.error('ERROR!!!', error: StandardError.new('test'))

begin
  def bob
    foo
  end

  def foo
    raise StandardError.new('foo')
  end

  bob
rescue => ex
  logger.warn('Oops, id: {id}', id: 1234, error: ex)
  logger.error('Oops, id: {id}', id: 1234, error: ex)

  logger.error {
    ['Testing error with a block, id: {id}', error: ex, id: 1234]
  }
end
