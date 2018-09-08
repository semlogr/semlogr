# frozen_string_literal: true

require 'bundler/setup'
require 'semlogr'

Semlogr.logger = Semlogr::Logger.create do |c|
  c.write_to :console, formatter: Semlogr::Formatters::JsonFormatter.new
end

Semlogr.with_context(id: 2, correlation_id: '1234')
  .info('Customer {id} checked out', id: 1)
