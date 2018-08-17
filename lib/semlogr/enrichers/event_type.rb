require 'semlogr/component_registry'

module Semlogr
  module Enrichers
    class EventType
      def enrich(log_event)
        log_event.add_property_if_absent(event_type: log_event.type)
      end
    end

    ComponentRegistry.register(:enricher, event_type: EventType)
  end
end
