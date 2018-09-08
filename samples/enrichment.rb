# frozen_string_literal: true

require 'bundler/setup'
require 'semlogr'

Semlogr.logger = Semlogr::Logger.create do |c|
  c.write_to :console, formatter: Semlogr::Formatters::JsonFormatter.new

  c.enrich_with :host
  c.enrich_with :thread
  c.enrich_with :property, correlation_id: '1234'
end

Semlogr.info('Customer {id} checked out', id: 1)
