module Semlogr
  class LogLevel
    include Comparable

    attr_reader :level

    def initialize(level, level_string)
      @level = level
      @level_string = level_string
    end

    def <=>(log_level)
      @level <=> log_level.level
    end

    def to_s
      @level_string
    end

    DEBUG = LogLevel.new(::Logger::DEBUG, 'DEBUG')
    INFO = LogLevel.new(::Logger::INFO, 'INFO')
    WARN = LogLevel.new(::Logger::WARN, 'WARN')
    ERROR = LogLevel.new(::Logger::ERROR, 'ERROR')
    FATAL = LogLevel.new(::Logger::FATAL, 'FATAL')
  end
end
