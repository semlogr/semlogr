# frozen_string_literal: true

require 'semlogr/formatters/text_formatter'

module Semlogr
  module Sinks
    class Console
      def initialize(formatter: nil)
        @formatter = formatter || Formatters::TextFormatter.new
      end

      def emit(log_event)
        output = @formatter.format(log_event)
        STDOUT.write(output)
      end
    end

    ComponentRegistry.register(:sink, console: Console)
  end
end
