module Semlogr
  module Templates
    class TextToken
      attr_accessor :text

      def initialize(text)
        @text = text
      end

      def render(output, properties)
        output << @text
      end

      def ==(other)
        return false unless other
        return false unless other.respond_to?(:text)

        @text == other.text
      end

      def eql?(other)
        self == other
      end

      def hash
        @text.hash
      end

      EMPTY = TextToken.new('')
    end
  end
end
