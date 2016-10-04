module Semlogr
  module Enrichers
    class Property
      def initialize(**properties)
        @properties = properties
      end

      def enrich(log_event)
        @properties.each do |name, value|
          log_event.set_property(name, value)
        end
      end
    end
  end
end
