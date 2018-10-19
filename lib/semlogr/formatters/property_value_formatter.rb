# frozen_string_literal: true

module Semlogr
  module Formatters
    class PropertyValueFormatter
      def self.format(value)
        case value
        when nil
          '(nil)'
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
