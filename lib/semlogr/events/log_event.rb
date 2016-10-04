module Semlogr
  module Events
    class LogEvent
      attr_reader :level
      attr_reader :template
      attr_reader :error
      attr_reader :properties
      attr_reader :timestamp

      def initialize(level, template, error, properties)
        @timestamp = Time.now.utc
        @level = level
        @template = template
        @error = error
        @properties = properties
      end

      def set_property(name, value)
        properties[name] = value
      end

      def render(output)
        @template.render(output, @properties)
      end
    end
  end
end
