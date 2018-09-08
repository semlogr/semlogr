# frozen_string_literal: true

require 'bundler/setup'
require 'semlogr'

Semlogr.logger = Semlogr::Logger.create do |c|
  c.write_to :console
end

Semlogr.info('Customer {id} checked out', id: 123)
Semlogr.error('Failed to save data', error: StandardError.new('foo'))
