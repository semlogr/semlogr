require 'socket'

module Semlogr
  module Enrichers
    class Machine
      def enrich(log_event)
        log_event.set_property(:machine_name, Socket.gethostname)
      end
    end
  end
end
