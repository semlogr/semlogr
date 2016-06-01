module Semlogr
  class LogConfigurator
    def initialize
      @min_level = ::Logger::DEBUG
      @sinks = []
    end

    def min_level(level)
      @min_level = level

      self
    end

    def write_to(sink)
      @sinks << sink

      self
    end

    def create_logger()
      Logger.new(@min_level, @sinks)
    end
  end
end
