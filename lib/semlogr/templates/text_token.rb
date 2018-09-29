# frozen_string_literal: true

module Semlogr
  module Templates
    TextToken = Struct.new(:text) do
      def render(output, _properties)
        output << text
      end

      def self.empty
        TextToken.new('')
      end
    end
  end
end
