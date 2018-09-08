# frozen_string_literal: true

module Semlogr
  module Formatters
    class PropertyValueFormatter
      QUOTE = '"'

      def self.format(output, value)
        case value
        when nil
          output << '(nil)'
        when String
          output << QUOTE
          output << value
          output << QUOTE
        when StandardError
          output << "#{value.class}: #{value.message}"

          if value.backtrace&.any?
            output << "\n\s\s#{value.backtrace.join("\n\s\s")}"
          end

          output << "\n"
        else
          output << value.to_s
        end
      end
    end
  end
end
