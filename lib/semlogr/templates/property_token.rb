# frozen_string_literal: true

require 'semlogr/formatters/property_value_formatter'
require 'semlogr/self_logger'
require 'date'

module Semlogr
  module Templates
    PropertyToken = Struct.new(:raw_text, :property_name, :format) do
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

      private

      def format_property_value(property_value)
        Formatters::PropertyValueFormatter.format(property_value, format)
      end
    end
  end
end
