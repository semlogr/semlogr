require 'semlogr/templates/parser'
require 'semlogr/properties/output_properties'
require 'semlogr/templates/property_token'

module Semlogr
  module Formatters
    class TextFormatter
      DEFAULT_TEMPLATE = "[{timestamp}] {severity}: {message}\n{error}"

      def initialize(template: DEFAULT_TEMPLATE)
        @template = Templates::Parser.parse(template)
      end

      def format(log_event)
        output = String.new
        properties = Properties::OutputProperties.create(log_event)

        @template.tokens.each do |token|
          case token
          when Templates::PropertyToken
            if token.property_name == :message
              log_event.render(output)
            else
              next unless properties[token.property_name]

              token.render(output, properties)
            end
          else
            token.render(output, properties)
          end
        end

        output
      end
    end
  end
end
