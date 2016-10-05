module Semlogr
  class LoggerConfiguration
    attr_reader :min_severity
    attr_reader :enrichers
    attr_reader :filters
    attr_reader :sinks

    def initialize
      @min_severity = LogSeverity::DEBUG
      @enrichers = []
      @filters = []
      @sinks = []
    end

    def log_at(severity)
      @min_severity = severity
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
