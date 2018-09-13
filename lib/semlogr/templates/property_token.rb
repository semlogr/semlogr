# frozen_string_literal: true

require 'semlogr/formatters/property_value_formatter'
require 'semlogr/self_logger'

module Semlogr
  module Templates
    class PropertyToken
      attr_reader :raw_text, :property_name, :format_string

      def initialize(raw_text, property_name, format = nil)
        @raw_text = raw_text
        @property_name = property_name
        @format_string = format ? "%#{format}" : nil
      end

      def render(output, properties)
        output <<
          if properties.key?(property_name)
            format_property_value(properties[property_name])
          else
            raw_text
          end
      rescue StandardError => e
        SelfLogger.error("Failed to render property token: #{property_name}", e)

        output << raw_text
      end

      def ==(other)
        return false unless other
        return false unless other.respond_to?(:raw_text)
        return false unless other.respond_to?(:property_name)
        return false unless other.respond_to?(:format_string)

        raw_text == other.raw_text && \
          property_name == other.property_name && \
          format_string == other.format_string
      end

      def eql?(other)
        self == other
      end

      def hash
        [raw_text, property_name, format_string].hash
      end

      private

      def format_property_value(property_value)
        if format_string
          format(format_string, property_value)
        else
          Formatters::PropertyValueFormatter.format(property_value)
        end
      end
    end
  end
end
