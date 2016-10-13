require 'semlogr/logger'

module Semlogr
  @logger = nil

  def self.configure
    @logger = Logger.create do |config|
      yield(config)
    end
  end

  def self.logger
    unless @logger
      raise StandardError, 'You need to initialize the logger instance by calling Semlogr::Log.configure first!'
    end

    @logger
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
