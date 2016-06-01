module Semlogr
  module Properties
    class ErrorValue
      def initialize(error)
        @error = error
      end

      def render
        return "" unless @error
        
        details = "#{@error.class}: #{@error.message}"
        details << "\n\s\s#{@error.backtrace.join("\n\s\s")}\n" if @error.backtrace

        return details
      end
    end
  end
end
