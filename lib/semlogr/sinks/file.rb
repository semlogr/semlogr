require 'semlogr/formatters/text_formatter'

module Semlogr
  module Sinks
    class File
      def initialize(file, shift_age: nil, shift_size: nil, formatter: nil)
        @logdev = ::Logger::LogDevice.new(file, shift_age: shift_age, shift_size: shift_size)
        @formatter = formatter || Formatters::TextFormatter.new
      end

      def log(log_event)
        output = @formatter.format(log_event)
        @logdev.write(output)
      end
    end
  end
end
