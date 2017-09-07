require 'semlogr/component_registry'
require 'semlogr/enrichers/aggregate'
require 'semlogr/sinks/aggregate'
require 'semlogr/sinks/filtering'

module Semlogr
  class LoggerConfiguration
    def initialize
      @min_severity = LogSeverity::DEBUG
      @enrichers = []
      @filters = []
      @sinks = []
    end

    def log_at(severity)
      @min_severity = LogSeverity.create(severity)
    end

    def filter(filter)
      @filters << filter
    end

    def enrich_with(enricher, *params)
      enricher = ComponentRegistry.resolve(:enricher, enricher, *params) if enricher.is_a?(Symbol)
      @enrichers << enricher
    end

    def write_to(sink, *params)
      sink = ComponentRegistry.resolve(:sink, sink, *params) if sink.is_a?(Symbol)
      @sinks << sink
    end

    def create_logger
      enricher = Enrichers::Aggregate.new(@enrichers)
      sink = Sinks::Aggregate.new(@sinks)
      sink = Sinks::Filtering.new(@filters, sink) if @filters.any?

      Logger.new(
        @min_severity,
        enricher,
        sink
      )
    end
  end
end
