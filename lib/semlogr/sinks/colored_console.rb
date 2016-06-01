require 'colorize'
require 'semlogr/sinks/console'
require 'semlogr/properties/output_properties'

module Semlogr
  module Sinks
    class ColoredConsole < Console
      LOG_LEVEL_COLORS = [:light_white, :white, :yellow, :light_red, :red]

      def log(message)
        rendered_template = ""
        template_properties = Properties::OutputProperties.new(message)

        @template.tokens.each do |token|
          case token
          when Templates::PropertyToken
            if token.property_name == :message
              rendered_template << render_message(message)
            elsif token.property_name == :level
              color = LOG_LEVEL_COLORS[message.level] || :light_white

              rendered_template << token.render(template_properties).colorize(color)
            else
              rendered_template << token.render(template_properties)
            end
          else
            rendered_template << token.render(template_properties)
          end
        end

        @logdev.write(rendered_template)
      end

      def render_message(message)
        rendered_message = ""

        message.template.tokens.each do |token|
          case token
          when Templates::PropertyToken
            rendered_message << token.render(message.properties).colorize(:light_blue)
          else
            rendered_message << token.render(message.properties)
          end
        end

        rendered_message
      end
    end
  end
end
