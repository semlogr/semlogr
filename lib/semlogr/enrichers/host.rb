require 'socket'

module Semlogr
  module Enrichers
    class Host
      def enrich(log_event)
        log_event.set_property(:host, Socket.gethostname)
      end
    end
  end
end
