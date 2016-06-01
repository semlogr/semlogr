module Semlogr
  module Properties
    class LogEventValue
      attr_reader :log_event

      def initialize(log_event)
        @log_event = log_event
      end

      def render
        @log_event.render
      end
    end
  end
end
