require 'semlogr/formatters/property_value_formatter'

module Semlogr
  module Templates
    class PropertyToken
      attr_accessor :property_name

      def initialize(raw_text, property_name)
        @raw_text = raw_text
        @property_name = property_name
      end

      def render(output, properties)
        property_value = properties[@property_name]
        if property_value
          Formatters::PropertyValueFormatter.format(output, property_value)
        else
          output << @raw_text
        end
      end

      def ==(other)
        return false unless other
        return false unless other.respond_to?(:property_name)

        @property_name == other.property_name
      end

      def eql?(other)
        self == other
      end

      def hash
        @property_name.hash
      end
    end
  end
end
