require 'json'

module Semlogr
  module Formatters
    class JsonFormatter
      def format(log_event)
        entry = {
          timestamp: log_event.timestamp.iso8601(3),
          severity: log_event.severity,
          message: render_message(log_event)
        }

        add_error(entry, log_event)
        add_properties(entry, log_event)

        "#{entry.to_json}\n"
      end

      private

      def add_error(entry, log_event)
        return unless log_event.error

        entry[:error] = {
          type: log_event.error.class,
          message: log_event.error.message,
          backtrace: log_event.error.backtrace
        }
      end

      def add_properties(entry, log_event)
        return unless log_event.properties.any?

        entry[:properties] = log_event.properties
      end

      def render_message(log_event)
        output = ''

        log_event.render(output)

        output
      end
    end
  end
end
