# frozen_string_literal: true

require 'semlogr/self_logger'

module Semlogr
  module Sinks
    class Filtering
      def initialize(filters, sink)
        @filters = filters
        @sink = sink
      end

      def emit(log_event)
        filtered = @filters.any? do |filter|
          begin
            filter.call(log_event)
          rescue StandardError => e
            SelfLogger.error("Failed to filter log event using filter #{filter.class}", e)

            false
          end
        end

        @sink.emit(log_event) unless filtered
      end
    end
  end
end
