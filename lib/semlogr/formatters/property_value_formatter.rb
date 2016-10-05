module Semlogr
  module Formatters
    class PropertyValueFormatter
      QUOTE = '"'.freeze

      def self.format(output, property_value)
        return unless property_value

        case property_value
        when String
          output << QUOTE
          output << property_value
          output << QUOTE
        when StandardError
          output << "#{property_value.class}: #{property_value.message}"

          if property_value.backtrace
            output << "\n\s\s#{property_value.backtrace.join("\n\s\s")}"
          end

          output << "\n"
        else
          output << property_value.to_s
        end
      end
    end
  end
end
