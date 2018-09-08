# frozen_string_literal: true

require 'semlogr/component_registry'

module Semlogr
  module Enrichers
    class Property
      def initialize(**properties)
        @properties = properties
      end

      def enrich(log_event)
        log_event.add_property_if_absent(@properties)
      end
    end

    ComponentRegistry.register(:enricher, property: Property)
  end
end
