module Semlogr
  module Sinks
    class Filtering
      def initialize(filters, sink)
        @filters = filters
        @sink = sink
      end

      def emit(log_event)
        filtered = @filters.any? { |filter| filter.call(log_event) }

        @sink.emit(log_event) unless filtered
      end
    end
  end
end
