# frozen_string_literal: true

module Semlogr
  module Properties
    class OutputProperties
      def self.create(log_event)
        properties = log_event.properties.merge(
          timestamp: log_event.timestamp,
          severity: log_event.severity
        )

        properties[:error] = log_event.error if log_event.error
        properties
      end
    end
  end
end
