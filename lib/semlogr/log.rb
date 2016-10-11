require 'semlogr/logger'

module Semlogr
  class Log
    def self.configure
      @logger = Logger.create do |config|
        yield(config)
      end
    end

    def self.debug(template = nil, **properties, &block)
      ensure_logger

      @logger.debug(template, **properties, &block)
    end

    def self.info(template = nil, **properties, &block)
      ensure_logger

      @logger.info(template, **properties, &block)
    end

    def self.warn(template = nil, **properties, &block)
      ensure_logger

      @logger.warn(template, **properties, &block)
    end

    def self.error(template = nil, **properties, &block)
      ensure_logger

      @logger.error(template, **properties, &block)
    end

    def self.fatal(template = nil, **properties, &block)
      ensure_logger

      @logger.fatal(template, **properties, &block)
    end

    class << self
      def ensure_logger
        raise StandardError, 'You need to initialize the logger instance by calling Semlogr::Log.configure first!' unless @logger
      end
    end
  end
end
