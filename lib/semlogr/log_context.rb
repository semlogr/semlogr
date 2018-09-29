# frozen_string_literal: true

module Semlogr
  class LogContext
    CURRENT_CONTEXT_KEY = :semlogr_log_context

    def self.current
      Thread.current[CURRENT_CONTEXT_KEY] ||= []
    end

    def self.current=(context)
      Thread.current[CURRENT_CONTEXT_KEY] = context.dup
    end

    def self.push_property(**properties)
      LogContext.current << properties

      yield if block_given?
    ensure
      LogContext.current.pop
    end

    def self.get_property(key)
      LogContext.current
        .reverse_each do |properties|
          return properties[key] if properties.key?(key)
        end

      nil
    end
  end
end
