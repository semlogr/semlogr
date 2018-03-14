require 'semlogr/sinks/console'
require 'semlogr/properties/output_properties'

module Semlogr
  module Sinks
    class ColoredConsole
      DEFAULT_TEMPLATE = "[{timestamp}] {severity}: {message}\n{error}".freeze

      LOG_SEVERITY_COLORS = {
        LogSeverity::DEBUG => :white,
        LogSeverity::INFO => :white,
        LogSeverity::WARN => :yellow,
        LogSeverity::ERROR => :red,
        LogSeverity::FATAL => :red
      }.freeze

      COLOR_CODES = {
        white: 37,
        yellow: 33,
        red: 31,
        blue: 34
      }.freeze

      def initialize(template: DEFAULT_TEMPLATE)
        @template = Templates::Parser.parse(template)
      end

      def emit(log_event)
        output = ''
        output_properties = Properties::OutputProperties.create(log_event)

        @template.tokens.each do |token|
          case token
          when Templates::PropertyToken
            render_property_token(output, token, log_event, output_properties)
          else
            token.render(output, output_properties)
          end
        end

        STDOUT.write(output)
      end

      private

      def render_property_token(output, token, log_event, output_properties)
        case token.property_name
        when :message
          render_message(output, log_event)
        when :severity
          colorize(output, LOG_SEVERITY_COLORS[log_event.severity]) do
            token.render(output, output_properties)
          end
        when :error
          return unless output_properties[:error]

          colorize(output, LOG_SEVERITY_COLORS[log_event.severity]) do
            token.render(output, output_properties)
          end
        else
          return unless output_properties[token.property_name]

          token.render(output, output_properties)
        end
      end

      def render_message(output, log_event)
        log_event.template.tokens.each do |token|
          case token
          when Templates::PropertyToken
            colorize(output, :blue) do
              token.render(output, log_event.properties)
            end
          else
            token.render(output, log_event.properties)
          end
        end
      end

      def colorize(output, color)
        color ||= :white

        output << "\e[#{COLOR_CODES[color]}m"
        yield
        output << "\e[0m"
      end
    end

    ComponentRegistry.register(:sink, colored_console: ColoredConsole)
  end
end
