require 'semlogr/templates/template'
require 'semlogr/templates/text_token'
require 'semlogr/templates/property_token'

module Semlogr
  module Templates
    class Parser
      def self.parse(template)
        return Template.empty unless template && template.size > 0

        tokens = []
        pos = 0

        while pos < template.size
          text_token, pos = parse_text_token(template, pos)
          tokens.push(text_token) if text_token

          property_token, pos = parse_property_token(template, pos)
          tokens.push(property_token) if property_token
        end

        Template.new(tokens)
      end

      private
      def self.parse_text_token(template, start)
        token = nil
        pos = start

        while pos < template.size
          break if template[pos] == '{'

          pos += 1
        end

        if pos > start
          text = template[start..pos-1]
          token = TextToken.new(text)
        end

        [token, pos]
      end

      def self.parse_property_token(template, start)
        return [nil, start] unless template[start] == '{'

        token = nil
        pos = start

        while pos < template.size
          if template[pos] == '}'
            property_name = template[start+1..pos-1]
            token = PropertyToken.new(property_name)

            return [token, pos+1]
          end

          pos += 1
        end

        if pos > start
          text = template[start..pos-1]
          token = TextToken.new(text)
        end

        [token, pos]
      end
    end
  end
end
