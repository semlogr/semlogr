require 'logger'
require 'semlogr/events/log_event'
require 'semlogr/templates/parser'
require 'semlogr/properties/message_properties'

module Semlogr
  class Logger
    def debug?; @min_level <= ::Logger::DEBUG; end
    def info?; @min_level <= ::Logger::INFO; end
    def warn?; @min_level <= ::Logger::WARN; end
    def error?; @min_level <= ::Logger::ERROR; end
    def fatal?; @min_level <= ::Logger::FATAL; end

    def initialize(min_level = ::Logger::DEBUG, sinks = [])
      @min_level = min_level
      @sinks = sinks
    end

    def debug(template = nil, error: nil, **properties, &block)
      log(::Logger::DEBUG, template, error, properties, &block)
    end

    def info(template = nil, error: nil, **properties, &block)
      log(::Logger::INFO, template, error, properties, &block)
    end

    def warn(template = nil, error: nil, **properties, &block)
      log(::Logger::WARN, template, error, properties, &block)
    end

    def error(template = nil, error: nil, **properties, &block)
      log(::Logger::ERROR, template, error, properties, &block)
    end

    def fatal(template = nil, error: nil, **properties, &block)
      log(::Logger::FATAL, template, error, properties, &block)
    end

    private

    def log(level, template, error, properties, &block)
      return true if @sinks.size == 0
      return true if level < @min_level

      if template.nil? && block_given?
        template, properties = yield

        properties ||= {}
        error = properties[:error]
      end

      message = create_log_event(level, template, error, properties)

      @sinks.each do |sink|
        sink.log(message)
      end

      true
    end

    def create_log_event(level, template, error, properties)
      template = Templates::Parser.parse(template)
      message_properties = Properties::MessageProperties.new(properties)

      Messages::LogEvent.new(level, template, error, message_properties)
    end
  end
end
