require 'semlogr/properties/property_value'
require 'semlogr/properties/error_value'
require 'semlogr/properties/log_level_value'
require 'semlogr/properties/log_event_value'

module Semlogr
  module Properties
    class OutputProperties
      def initialize(log_event)
        @properties = {
          timestamp: Properties::PropertyValue.new(log_event.timestamp),
          level: Properties::LogLevelValue.new(log_event.level),
          message: Properties::LogEventValue.new(log_event),
          error: Properties::ErrorValue.new(log_event.error)
        }
      end

      def [](property_name)
        @properties[property_name]
      end
    end
  end
end
