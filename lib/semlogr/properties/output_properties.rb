module Semlogr
  module Properties
    class OutputProperties
      def self.create(log_event)
        properties = {
          timestamp: log_event.timestamp,
          level: log_event.level
        }

        if log_event.error
          properties[:error] = log_event.error
        end

        properties
      end
    end
  end
end
