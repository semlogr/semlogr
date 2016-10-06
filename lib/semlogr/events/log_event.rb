module Semlogr
  module Events
    class LogEvent
      attr_reader :severity
      attr_reader :template
      attr_reader :error
      attr_reader :properties
      attr_reader :timestamp

      def initialize(severity, template, error, properties)
        @timestamp = Time.now.utc
        @severity = severity
        @template = template
        @error = error
        @properties = properties
      end

      def get_property(name)
        @properties[name]
      end

      def add_property(properties)
        @properties.merge!(properties)
      end

      def render(output)
        @template.render(output, @properties)
      end

      def to_s
        output = ''

        render(output)

        output
      end
    end
  end
end
