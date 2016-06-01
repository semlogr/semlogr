module Semlogr
  module Sinks
    class Console
      DEFAULT_TEMPLATE = "[{timestamp}] {level}: {message}\n{error}"

      def initialize(template: DEFAULT_TEMPLATE)
        @logdev = ::Logger::LogDevice.new(STDOUT)
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
