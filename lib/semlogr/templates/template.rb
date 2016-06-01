module Semlogr
  module Templates
    class Template
      attr_accessor :tokens

      def initialize(tokens)
        @tokens = tokens
      end

      def self.empty
        Template.new([TextToken.empty])
      end

      def render(properties)
        rendered = ""

        @tokens.each do |token|
          rendered << token.render(properties)
        end

        rendered
      end
    end
  end
end
