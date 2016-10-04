module Semlogr
  module Enrichers
    class Property
      def initialize(**properties)
        @properties = properties
      end

      def enrich(log_event)
        log_event.set_properties(@properties)
      end
    end
  end
end
