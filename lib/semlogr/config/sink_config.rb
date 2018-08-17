require 'semlogr/component_registry'
require 'semlogr/sinks/enriching'
require 'semlogr/sinks/filtering'
require 'semlogr/log_severity'

module Semlogr
  module Config
    class SinkConfig
      def initialize
        @min_severity = LogSeverity::DEBUG
        @enrichers = []
        @filters = []
      end

      def emit_at(severity)
        @min_severity = LogSeverity.create(severity)
      end

      def filter(filter)
        @filters << filter
      end

      def enrich_with(enricher, *params)
        enricher = ComponentRegistry.resolve(:enricher, enricher, *params) if enricher.is_a?(Symbol)
        @enrichers << enricher
      end

      def create_sink(sink, *params)
        if sink.is_a?(Symbol)
          sink = ComponentRegistry.resolve(:sink, sink, *params)
        end

        if @min_severity > LogSeverity::DEBUG
          severity_filter = ->(log_event) { log_event.severity < @min_severity }
          @filters.unshift(severity_filter)
        end

        sink = Sinks::Filtering.new(@filters, sink) if @filters.any?
        sink = Sinks::Enriching.new(@enrichers, sink) if @enrichers.any?
        sink
      end
    end
  end
end
