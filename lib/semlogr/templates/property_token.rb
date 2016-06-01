module Semlogr
  module Templates
    class PropertyToken
      attr_accessor :property_name

      def initialize(property_name)
        @property_name = property_name.to_sym
        @text = "{#{property_name}}"
      end

      def render(properties)
        property_value = properties[@property_name]

        return @text unless property_value
        return property_value.render
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
