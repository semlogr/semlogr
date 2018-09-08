# frozen_string_literal: true

module Semlogr
  class SelfLogger
    def self.debug(message, error = nil)
      log(:debug, message, error)
    end

    def self.info(message, error = nil)
      log(:info, message, error)
    end

    def self.warn(message, error = nil)
      log(:warn, message, error)
    end

    def self.error(message, error = nil)
      log(:error, message, error)
    end

    def self.fatal(message, error = nil)
      log(:fatal, message, error)
    end

    class << self
      attr_accessor :logger

      private

      def log(severity, message, error)
        return unless logger

        logger << format_message(severity, message, error)
      end

      def format_message(severity, message, error)
        formatted = +"[#{Time.now.iso8601(3)}] #{severity.upcase}: #{message}"

        if error
          case error
          when StandardError
            formatted << "\n#{error.class}: #{error.message}"

            if error.backtrace&.any?
              formatted << "\n\s\s#{error.backtrace.join("\n\s\s")}"
            end
          else
            formatted << "\n#{error}"
          end
        end

        formatted << "\n"
      end
    end
  end
end
