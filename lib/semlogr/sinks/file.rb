require 'logger'
require 'semlogr/formatters/text_formatter'

module Semlogr
  module Sinks
    class File
      def initialize(file, shift_age: 0, shift_size: 1_048_576, formatter: nil)
        @logdev = ::Logger::LogDevice.new(file, shift_age: shift_age, shift_size: shift_size)
        @formatter = formatter || Formatters::TextFormatter.new
      end

      def emit(log_event)
        output = @formatter.format(log_event)
        @logdev.write(output)
      end
    end

    ComponentRegistry.register(:sink, file: File)
  end
end
