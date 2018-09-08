# frozen_string_literal: true

require 'semlogr/component_registry'

module Semlogr
  module Enrichers
    class Thread
      def enrich(log_event)
        log_event.add_property_if_absent(thread_id: ::Thread.current.object_id)
      end
    end

    ComponentRegistry.register(:enricher, thread: Thread)
  end
end
