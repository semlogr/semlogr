require 'semlogr/properties/property_value'

module Semlogr
  module Properties
    class MessageProperties
      def initialize(properties)
        @properties = {}

        properties.each do |property_name, value|
          @properties[property_name] = PropertyValue.new(value)
        end
      end

      def [](property_name)
        @properties[property_name]
      end
    end
  end
end
