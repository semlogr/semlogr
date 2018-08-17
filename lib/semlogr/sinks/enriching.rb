module Semlogr
  module Sinks
    class Enriching
      def initialize(enrichers, sink)
        @enrichers = enrichers
        @sink = sink
      end

      def emit(log_event)
        @enrichers.each { |enricher| enricher.enrich(log_event) }
        @sink.emit(log_event)
      end
    end
  end
end
