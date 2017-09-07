require 'socket'
require 'semlogr/component_registry'

module Semlogr
  module Enrichers
    class Host
      def enrich(log_event)
        log_event.add_property_if_absent(host: Socket.gethostname)
      end
    end

    ComponentRegistry.register(:enricher, host: Host)
  end
end
