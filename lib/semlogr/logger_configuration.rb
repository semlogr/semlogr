module Semlogr
  class LoggerConfiguration
    attr_reader :level
    attr_reader :enrichers
    attr_reader :filters
    attr_reader :sinks

    def initialize
      @level = ::Logger::DEBUG
      @enrichers = []
      @filters = []
      @sinks = []
    end

    def min_level(level)
      @level = level
    end

    def filter_when(filter)
      @filters << filter
    end

    def enrich_with(enricher)
      @enrichers << enricher
    end

    def write_to(sink)
      @sinks << sink
    end
  end
end
