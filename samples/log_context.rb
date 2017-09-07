require 'bundler/setup'
require 'semlogr'

Semlogr.logger = Semlogr::Logger.create do |c|
  c.write_to :console, formatter: Semlogr::Formatters::JsonFormatter.new

  c.enrich_with :log_context
end

Semlogr::Context::LogContext.push_property(a: 1) do
  Semlogr.info('Customer {id} checked out', id: 1)
end
