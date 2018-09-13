# frozen_string_literal: true

require 'semlogr/self_logger'

module Semlogr
  module Sinks
    class Aggregate
      def initialize(sinks)
        @sinks = sinks
      end

      def emit(log_event)
        @sinks.each do |sink|
          begin
            sink.emit(log_event)
          rescue StandardError => e
            SelfLogger.error("Failed to emit log event to sink #{sink.class}", e)
          end
        end
      end
    end
  end
end
