# frozen_string_literal: true

require 'semlogr/component_registry'
require 'semlogr/sinks/aggregate'
require 'semlogr/sinks/enriching'
require 'semlogr/sinks/filtering'
require 'semlogr/config/sink_config'
require 'semlogr/logger'
require 'semlogr/log_severity'

module Semlogr
  module Config
    class LoggerConfig
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
        enricher = resolve_enricher(enricher, params)
        @enrichers << enricher
      end

      def write_to(sink, *params)
        sink_config = SinkConfig.new
        yield(sink_config) if block_given?

        @sinks << sink_config.create_sink(sink, *params)
      end

      def create_logger
        sink = Sinks::Aggregate.new(@sinks)
        sink = Sinks::Filtering.new(@filters, sink) if @filters.any?
        sink = Sinks::Enriching.new(@enrichers, sink) if @enrichers.any?

        Logger.new(@min_severity, sink)
      end

      private

      def resolve_enricher(enricher, params)
        return enricher unless enricher.is_a?(Symbol)

        ComponentRegistry.resolve(:enricher, enricher, *params)
      end
    end
  end
end
