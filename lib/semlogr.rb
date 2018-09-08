# frozen_string_literal: true

require 'semlogr/logger'
require 'semlogr/log_context'
require 'semlogr/null_logger'
require 'semlogr/self_logger'
require 'semlogr/version'

# Built-in enrichers
require 'semlogr/enrichers/event_type'
require 'semlogr/enrichers/host'
require 'semlogr/enrichers/log_context'
require 'semlogr/enrichers/property'
require 'semlogr/enrichers/thread'

# Built-in sinks
require 'semlogr/sinks/console'
require 'semlogr/sinks/colored_console'
require 'semlogr/sinks/file'

# Built-in formatters
require 'semlogr/formatters/json_formatter'
require 'semlogr/formatters/text_formatter'

module Semlogr
  @logger = nil

  def self.create_logger
    Logger.create do |config|
      yield(config)
    end
  end

  def self.logger=(logger)
    @logger = logger
  end

  def self.logger
    @logger ||= NullLogger.new
  end

  def self.debug(template = nil, **properties, &block)
    logger.debug(template, properties, &block)
  end

  def self.info(template = nil, **properties, &block)
    logger.info(template, properties, &block)
  end

  def self.warn(template = nil, **properties, &block)
    logger.warn(template, properties, &block)
  end

  def self.error(template = nil, **properties, &block)
    logger.error(template, properties, &block)
  end

  def self.fatal(template = nil, **properties, &block)
    logger.fatal(template, properties, &block)
  end

  def self.with_context(**properties)
    logger.with_context(properties)
  end
end
