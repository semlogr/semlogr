require 'delegate'

module Semlogr
  module Utils
    class BoundedQueue
      def initialize(max_size)
        @max_size = max_size
        @queue = Queue.new
        @queue_mutex = Mutex.new
      end

      def size
        @queue.size
      end

      def push(item)
        @queue_mutex.synchronize do
          return if size >= @max_size

          @queue << item
        end
      end

      def pop
        @queue.pop
      end

      def pop_count(count)
        items = []

        @queue_mutex.synchronize do
          items << @queue.pop until @queue.empty? || items.size == count
        end

        items
      end
    end
  end
end
