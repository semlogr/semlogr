require 'semlogr/version'
require 'semlogr/logger'
require 'semlogr/null_logger'

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
    logger.debug(template, **properties, &block)
  end

  def self.info(template = nil, **properties, &block)
    logger.info(template, **properties, &block)
  end

  def self.warn(template = nil, **properties, &block)
    logger.warn(template, **properties, &block)
  end

  def self.error(template = nil, **properties, &block)
    logger.error(template, **properties, &block)
  end

  def self.fatal(template = nil, **properties, &block)
    logger.fatal(template, **properties, &block)
  end
end
