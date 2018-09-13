# frozen_string_literal: true

require 'semlogr/self_logger'

module Semlogr
  module Sinks
    class Enriching
      def initialize(enrichers, sink)
        @enrichers = enrichers
        @sink = sink
      end

      def emit(log_event)
        @enrichers.each do |enricher|
          begin
            enricher.enrich(log_event)
          rescue StandardError => e
            SelfLogger.error("Failed to enrich log event using enricher #{enricher.class}", e)
          end
        end

        @sink.emit(log_event)
      end
    end
  end
end
