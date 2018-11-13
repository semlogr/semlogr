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
            Formatters::PropertyValueFormatter.format(properties[property_name], format)
          else
            raw_text
          end
      rescue StandardError => e
        SelfLogger.error("Failed to render property token: #{property_name}", e)

        output << raw_text
      end
    end
  end
end
