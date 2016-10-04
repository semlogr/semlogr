require 'logger'
require 'semlogr/logger_configuration'
require 'semlogr/log_level'
require 'semlogr/events/log_event'
require 'semlogr/templates/parser'

module Semlogr
  class Logger
    def debug?; @level <= LogLevel::DEBUG; end
    def info?; @level <= LogLevel::INFO; end
    def warn?; @level <= LogLevel::WARN; end
    def error?; @level <= LogLevel::ERROR; end
    def fatal?; @level <= LogLevel::FATAL; end

    def initialize(config)
      @level = config.level
      @enrichers = config.enrichers
      @sinks = config.sinks
    end

    def self.create
      config = LoggerConfiguration.new
      yield(config)

      Logger.new(config)
    end

    def debug(template = nil, error: nil, **properties, &block)
      log(LogLevel::DEBUG, template, error, properties, &block)
    end

    def info(template = nil, error: nil, **properties, &block)
      log(LogLevel::INFO, template, error, properties, &block)
    end

    def warn(template = nil, error: nil, **properties, &block)
      log(LogLevel::WARN, template, error, properties, &block)
    end

    def error(template = nil, error: nil, **properties, &block)
      log(LogLevel::ERROR, template, error, properties, &block)
    end

    def fatal(template = nil, error: nil, **properties, &block)
      log(LogLevel::FATAL, template, error, properties, &block)
    end

    private

    def log(level, template, error, properties, &block)
      return true if @sinks.size == 0
      return true if level < @level

      if template.nil? && block_given?
        template, properties = yield

        properties ||= {}
        error = properties[:error]
      end

      log_event = create_log_event(level, template, error, properties)

      @enrichers.each do |enricher|
        enricher.enrich(log_event)
      end

      @sinks.each do |sink|
        sink.emit(log_event)
      end

      true
    end

    def create_log_event(level, template, error, properties)
      template = Templates::Parser.parse(template)

      Events::LogEvent.new(level, template, error, properties)
    end
  end
end
