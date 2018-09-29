# frozen_string_literal: true

require 'semlogr/templates/text_token'

module Semlogr
  module Templates
    Template = Struct.new(:text, :tokens) do
      def render(output, properties)
        tokens.each do |token|
          token.render(output, properties)
        end
      end

      def self.empty
        Template.new('', [TextToken.empty])
      end
    end
  end
end
