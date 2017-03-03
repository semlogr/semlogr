require 'logger'
require 'semlogr/logger_configuration'
require 'semlogr/log_severity'
require 'semlogr/events/log_event'
require 'semlogr/templates/parser'
require 'semlogr/enrichers/property'

module Semlogr
  class Logger
    def initialize(min_severity, enrichers, filters, sinks)
      @min_severity = min_severity
      @filters = filters
      @enrichers = enrichers
      @sinks = sinks
    end

    def self.create
      config = LoggerConfiguration.new
      yield(config)

      config.create_logger
    end

    def debug?
      @min_severity <= LogSeverity::DEBUG
    end

    def info?
      @min_severity <= LogSeverity::INFO
    end

    def warn?
      @min_severity <= LogSeverity::WARN
    end

    def error?
      @min_severity <= LogSeverity::ERROR
    end

    def fatal?
      @min_severity <= LogSeverity::FATAL
    end

    def debug(template = nil, error: nil, **properties, &block)
      log(LogSeverity::DEBUG, template, error, properties, &block)
    end

    def info(template = nil, error: nil, **properties, &block)
      log(LogSeverity::INFO, template, error, properties, &block)
    end

    def warn(template = nil, error: nil, **properties, &block)
      log(LogSeverity::WARN, template, error, properties, &block)
    end

    def error(template = nil, error: nil, **properties, &block)
      log(LogSeverity::ERROR, template, error, properties, &block)
    end

    def fatal(template = nil, error: nil, **properties, &block)
      log(LogSeverity::FATAL, template, error, properties, &block)
    end

    def with_context(**properties)
      Logger.new(
        @min_severity,
        @enrichers + [Enrichers::Property.new(properties)],
        @filters,
        @sinks
      )
    end

    private

    def log(severity, template, error, properties, &block)
      return true if @sinks.size.zero?
      return true if severity < @min_severity

      if block
        progname = template
        template, properties = yield

        properties ||= {}
        properties[:progname] = progname if progname
        error = properties.delete(:error)
      end

      log_event = create_log_event(severity, template, error, properties)
      return false if filter?(log_event)

      enrich(log_event)
      emit(log_event)

      true
    end

    def create_log_event(severity, template, error, properties)
      template = Templates::Parser.parse(template)

      Events::LogEvent.new(severity, template, error, properties)
    end

    def filter?(log_event)
      @filters.each do |filter|
        return true if filter.call(log_event)
      end

      false
    end

    def enrich(log_event)
      @enrichers.each do |enricher|
        enricher.enrich(log_event)
      end
    end

    def emit(log_event)
      @sinks.each do |sink|
        sink.emit(log_event)
      end
    end
  end
end
