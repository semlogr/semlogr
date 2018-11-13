# frozen_string_literal: true

module Semlogr
  module Formatters
    class PropertyValueFormatter
      def self.format(value, format)
        return '(nil)' unless value

        if format
          case value
          when DateTime, Date, Time
            value.strftime(format)
          else
            Kernel.format("%#{format}", value)
          end
        else
          case value
          when String
            "\"#{value}\""
          when StandardError
            formatted_error = +"#{value.class}: #{value.message}"

            if value.backtrace&.any?
              formatted_error << "\n\s\s#{value.backtrace.join("\n\s\s")}"
            end

            formatted_error << "\n"
          else
            value.to_s
          end
        end
      end
    end
  end
end
