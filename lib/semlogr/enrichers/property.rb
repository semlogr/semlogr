module Semlogr
  module Enrichers
    class Property
      def initialize(property_name, property_value)
        @property_name = property_name
        @property_value = property_value
      end

      def enrich(log_event)
        log_event.set_property(@property_name, @property_value)
      end
    end
  end
end
