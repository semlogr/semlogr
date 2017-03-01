require 'oj'

module Semlogr
  module Formatters
    class JsonFormatter
      def format(log_event)
        event = {
          timestamp: log_event.timestamp.iso8601(3),
          severity: log_event.severity,
          message: log_event.to_s
        }

        add_error(event, log_event.error)
        add_properties(event, log_event.properties)

        yield(event) if block_given?

        event_json = Oj.dump(event, mode: :compat, use_to_json: true)
        "#{event_json}\n"
      end

      private

      def add_error(event, error)
        return unless error

        backtrace = error.backtrace || []
        event[:error] = {
          type: error.class,
          message: error.message,
          backtrace: backtrace
        }
      end

      def add_properties(event, properties)
        return unless properties.any?

        event[:properties] = properties
      end
    end
  end
end
