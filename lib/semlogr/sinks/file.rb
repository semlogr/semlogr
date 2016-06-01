module Semlogr
  module Sinks
    class File
      DEFAULT_TEMPLATE = "[{timestamp}] {level}: {message}\n{error}"

      def initialize(file, shift_age: nil, shift_size: nil, template: DEFAULT_TEMPLATE)
        @logdev = ::Logger::LogDevice.new(file, shift_age: shift_age, shift_size: shift_size)
        @template = Templates::Parser.parse(template)
      end

      def log(message)
        properties = Properties::OutputProperties.new(message)
        rendered = @template.render(properties)

        @logdev.write(rendered)
      end
    end
  end
end
