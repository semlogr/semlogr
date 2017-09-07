module Semlogr
  module Enrichers
    class Aggregate
      def initialize(enrichers)
        @enrichers = enrichers
      end

      def enrich(log_event)
        @enrichers.each do |enricher|
          enricher.enrich(log_event)
        end
      end
    end
  end
end
