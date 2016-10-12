require 'semlogr/logger'

module Semlogr
  VERSION = '0.1.0'.freeze

  class << self
    @logger = nil

    def configure
      @logger = Logger.create do |config|
        yield(config)
      end
    end

    def logger
      unless @logger
        raise StandardError, 'You need to initialize the logger instance by calling Semlogr::Log.configure first!'
      end

      @logger
    end

    def debug(template = nil, **properties, &block)
      logger.debug(template, **properties, &block)
    end

    def info(template = nil, **properties, &block)
      logger.info(template, **properties, &block)
    end

    def warn(template = nil, **properties, &block)
      logger.warn(template, **properties, &block)
    end

    def error(template = nil, **properties, &block)
      logger.error(template, **properties, &block)
    end

    def fatal(template = nil, **properties, &block)
      logger.fatal(template, **properties, &block)
    end
  end
end
