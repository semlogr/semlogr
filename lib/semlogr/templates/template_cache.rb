require 'lru_redux'

module Semlogr
  module Templates
    class TemplateCache
      def initialize(max_size)
        @template_cache = LruRedux::ThreadSafeCache.new(max_size)
      end

      def [](key)
        @template_cache[key]
      end

      def []=(key, value)
        @template_cache[key] = value
      end
    end
  end
end
