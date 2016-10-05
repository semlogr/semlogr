module Semlogr
  class LogSeverity
    include Comparable

    attr_reader :value

    def initialize(value, display_string)
      @value = value
      @display_string = display_string
    end

    def <=>(other)
      @value <=> other.value
    end

    def to_s
      @display_string
    end

    DEBUG = LogSeverity.new(::Logger::DEBUG, 'DEBUG')
    INFO = LogSeverity.new(::Logger::INFO, 'INFO')
    WARN = LogSeverity.new(::Logger::WARN, 'WARN')
    ERROR = LogSeverity.new(::Logger::ERROR, 'ERROR')
    FATAL = LogSeverity.new(::Logger::FATAL, 'FATAL')
  end
end
