module Semlogr
  module Sinks
    class Aggregate
      def initialize(sinks)
        @sinks = sinks
      end

      def emit(log_event)
        @sinks.each do |sink|
          sink.emit(log_event)
        end
      end
    end
  end
end
