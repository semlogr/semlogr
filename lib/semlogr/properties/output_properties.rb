module Semlogr
  module Properties
    class OutputProperties
      def self.create(log_event)
        properties = log_event.properties.merge({
          timestamp: log_event.timestamp,
          severity: log_event.severity
        })

        if log_event.error
          properties[:error] = log_event.error
        end

        properties
      end
    end
  end
end
