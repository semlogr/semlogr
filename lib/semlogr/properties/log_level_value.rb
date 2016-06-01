module Semlogr
  module Properties
    class LogLevelValue
      LOG_LEVEL_STRINGS = %w(DEBUG INFO WARN ERROR FATAL)

      def initialize(level)
        @level = level
      end

      def render
        LOG_LEVEL_STRINGS[@level] || 'ANY'
      end
    end
  end
end
