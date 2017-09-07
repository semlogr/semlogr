require 'semlogr/context/log_context'

module Semlogr
  module Enrichers
    class LogContext
      def enrich(log_event)
        Context::LogContext.current
          .each do |properties|
            log_event.add_property_if_absent(properties)
          end
      end
    end

    ComponentRegistry.register(:enricher, log_context: LogContext)
  end
end
