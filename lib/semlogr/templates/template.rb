require 'semlogr/templates/text_token'

module Semlogr
  module Templates
    class Template
      attr_accessor :tokens

      def initialize(tokens)
        @tokens = tokens
      end

      def render(output, properties)
        @tokens.each do |token|
          token.render(output, properties)
        end
      end

      EMPTY = Template.new([TextToken::EMPTY])
    end
  end
end
