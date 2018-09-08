# frozen_string_literal: true

require 'bundler/setup'
require 'semlogr'

Semlogr.logger = Semlogr::Logger.create do |c|
  c.write_to :console

  c.filter ->(e) { e.get_property(:id) == 123 }
end

Semlogr.info('Customer {id} checked out', id: 123)
Semlogr.info('Customer {id} checked out', id: 456)
