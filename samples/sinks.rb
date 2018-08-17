require 'bundler/setup'
require 'semlogr'

Semlogr.logger = Semlogr::Logger.create do |c|
  c.write_to :console, formatter: Semlogr::Formatters::JsonFormatter.new

  c.write_to :colored_console do |s|
    s.emit_at :error
  end
end

Semlogr.info('Customer {id} checked out', id: 123)
Semlogr.error('Failed to save data', error: StandardError.new('foo'))
