require 'json'

module Semlogr
  module Formatters
    class JsonFormatter
      def format(log_event)
        entry = {
          timestamp: log_event.timestamp,
          severity: log_event.severity,
          message: render_message(log_event)
        }

        if log_event.error
          entry[:error] = {
            type: log_event.error.class,
            message: log_event.error.message,
            backtrace: log_event.error.backtrace
          }
        end

        if log_event.properties.any?
          entry[:properties] = log_event.properties
        end

        "#{entry.to_json}\n"
      end

      private

      def render_message(log_event)
        output = String.new

        log_event.render(output)

        output
      end
    end
  end
end
