require 'semlogr/utils/bounded_queue'
require 'timeout'

module Semlogr
  module Sinks
    class Batching
      MAX_FLUSH_ATTEMPTS = 6

      def initialize(opts = {})
        @flush_interval = opts[:flush_interval] || 3
        @final_flush_timeout = opts[:final_flush_timeout] || 60
        @batch_size = opts[:batch_size] || 1_000
        @queue_max_size = opts[:queue_max_size] || 100_000
        @queue = Utils::BoundedQueue.new(@queue_max_size)
        @flush_mutex = Mutex.new
        @running = false

        start_flush_thread

        at_exit { stop_flush_thread }
      end

      def emit(log_event)
        return unless @running

        @queue.push(log_event)
      end

      private

      def flush
        @flush_mutex.synchronize do
          loop do
            log_events = @queue.pop_count(@batch_size)
            success = emit_batch_with_retries(log_events)

            break unless success
            break if log_events.empty? || log_events.size < @batch_size
          end
        end
      end

      def emit_batch_with_retries(log_events)
        return true if log_events.empty?

        flush_attempts = 0

        begin
          emit_batch(log_events)
        rescue StandardError
          flush_attempts += 1

          if flush_attempts <= MAX_FLUSH_ATTEMPTS
            sleep 2**flush_attempts
            retry
          end

          return false
        end

        true
      end

      def start_flush_thread
        @running = true

        Thread.new do
          loop do
            break unless @running

            sleep @flush_interval
            flush
          end
        end
      end

      def stop_flush_thread
        @running = false

        Timeout.timeout(@final_flush_timeout) { flush }
      end
    end
  end
end
