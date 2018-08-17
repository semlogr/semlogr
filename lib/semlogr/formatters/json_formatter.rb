require 'oj'

module Semlogr
  module Formatters
    class JsonFormatter
      def initialize(opts = {})
        default_opts = {
          mode: :custom,
          time_format: :ruby,
          use_to_json: true
        }

        @opts = default_opts.merge(opts)
      end

      def format(log_event)
        event = {
          timestamp: log_event.timestamp.iso8601(3),
          severity: log_event.severity.to_s,
          message: log_event.to_s
        }

        add_error(event, log_event.error)
        add_properties(event, log_event.properties)

        event = yield(event) if block_given?
        event_json = Oj.dump(event, @opts)
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
