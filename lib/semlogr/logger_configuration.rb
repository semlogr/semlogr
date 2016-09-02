module Semlogr
  class LoggerConfiguration
    attr_reader :level
    attr_reader :sinks

    def initialize
      @level = ::Logger::DEBUG
      @sinks = []
    end

    def min_level(level)
      @level = level
    end

    def write_to(sink)
      @sinks << sink
    end
  end
end
