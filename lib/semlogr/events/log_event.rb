module Semlogr
  module Messages
    class LogEvent
      attr_reader :level
      attr_reader :template
      attr_reader :error
      attr_reader :properties
      attr_reader :timestamp

      def initialize(level, template, error, properties)
        @level = level
        @template = template
        @error = error
        @properties = properties
        @timestamp = DateTime.now
      end

      def render
        @template.render(@properties)
      end
    end
  end
end
