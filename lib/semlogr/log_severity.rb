module Semlogr
  class LogSeverity
    include Comparable

    attr_reader :value

    def initialize(value, display_string)
      @value = value
      @display_string = display_string
    end

    def self.create(severity)
      case severity
      when LogSeverity
        severity
      when :debug
        LogSeverity::DEBUG
      when :info
        LogSeverity::INFO
      when :warn
        LogSeverity::WARN
      when :error
        LogSeverity::ERROR
      when :fatal
        LogSeverity::FATAL
      else
        LogSeverity::DEBUG
      end
    end

    def <=>(other)
      @value <=> other.value
    end

    def to_s
      @display_string
    end

    DEBUG = LogSeverity.new(0, 'DEBUG')
    INFO = LogSeverity.new(1, 'INFO')
    WARN = LogSeverity.new(2, 'WARN')
    ERROR = LogSeverity.new(3, 'ERROR')
    FATAL = LogSeverity.new(4, 'FATAL')
  end
end
