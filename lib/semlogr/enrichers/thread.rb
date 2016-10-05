module Semlogr
  module Enrichers
    class Thread
      def enrich(log_event)
        log_event.add_property(thread_id: ::Thread.current.object_id)
      end
    end
  end
end
