# frozen_string_literal: true

require 'semlogr/config/logger_config'
require 'semlogr/log_severity'
require 'semlogr/events/log_event'
require 'semlogr/sinks/enriching'
require 'semlogr/enrichers/property'

module Semlogr
  class Logger
    def initialize(min_severity, sink)
      @min_severity = min_severity
      @sink = sink
    end

    def self.create
      config = Config::LoggerConfig.new
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

    def debug(template = nil, **properties, &block)
      log(LogSeverity::DEBUG, template, properties, &block)
    end

    def info(template = nil, **properties, &block)
      log(LogSeverity::INFO, template, properties, &block)
    end

    def warn(template = nil, **properties, &block)
      log(LogSeverity::WARN, template, properties, &block)
    end

    def error(template = nil, **properties, &block)
      log(LogSeverity::ERROR, template, properties, &block)
    end

    def fatal(template = nil, **properties, &block)
      log(LogSeverity::FATAL, template, properties, &block)
    end

    def with_context(**properties)
      property_enricher = Enrichers::Property.new(properties)
      sink = Sinks::Enriching.new([property_enricher], @sink)

      Logger.new(@min_severity, sink)
    end

    private

    def log(severity, template, properties, &block)
      return true if severity < @min_severity

      if block
        progname = template
        template, properties = yield

        properties ||= {}
        properties[:progname] = progname if progname
      end

      log_event = Events::LogEvent.create(severity, template, properties)
      @sink.emit(log_event)

      true
    end
  end
end
