module Semlogr
  module Context
    class LogContext
      def self.current
        Thread.current[:semlogr_log_context] ||= []
      end

      def self.push_property(**properties)
        LogContext.current << properties

        yield if block_given?
      ensure
        LogContext.current.pop
      end

      def self.get_property(key)
        LogContext.current
          .reverse_each
          .each do |properties|
            return properties[key] if properties.key?(key)
          end

        nil
      end
    end
  end
end
