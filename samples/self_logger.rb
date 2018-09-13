# frozen_string_literal: true

require 'bundler/setup'
require 'semlogr'

class TestSink
  def emit(_log_event)
    raise StandardError, 'emit error'
  end
end

class TestEnricher
  def enrich(_log_event)
    raise StandardError, 'enrich error'
  end
end

Semlogr::SelfLogger.logger = STDERR
Semlogr.logger = Semlogr::Logger.create do |c|
  c.write_to :console

  c.write_to TestSink.new
  c.enrich_with TestEnricher.new
  c.filter ->(_log_event) { raise StandardError, 'filter error' }
end

Semlogr.info('Customer {id} checked out', id: 123)
