module Semlogr
  module Properties
    class PropertyValue
      def initialize(value)
        @value = value
      end

      def render
        return "" unless @value

        case @value
        when String
          return "\"#{@value}\""
        else
          return @value.to_s
        end
      end
    end
  end
end
