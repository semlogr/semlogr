# frozen_string_literal: true

require 'semlogr/templates/template'
require 'semlogr/templates/text_token'
require 'semlogr/templates/property_token'
require 'semlogr/templates/template_cache'

module Semlogr
  module Templates
    class Parser
      @template_cache = TemplateCache.new(1000)

      PROPERTY_TOKEN_START = '{'
      PROPERTY_TOKEN_END = '}'
      FILTER_TOKEN_START = ':'

      def self.parse(template)
        return Template::EMPTY unless template && !template.empty?

        cached_template = @template_cache[template]
        return cached_template if cached_template

        tokens = []
        pos = 0

        while pos < template.size
          text_token, pos = parse_text_token(template, pos)
          tokens.push(text_token) if text_token

          property_token, pos = parse_property_token(template, pos)
          tokens.push(property_token) if property_token
        end

        @template_cache[template] = Template.new(template, tokens)
      end

      def self.parse_text_token(template, start)
        token = nil
        pos = start

        while pos < template.size
          break if template[pos] == PROPERTY_TOKEN_START

          pos += 1
        end

        if pos > start
          text = template[start..pos - 1]
          token = TextToken.new(text)
        end

        [token, pos]
      end

      def self.parse_property_token(template, start)
        return [nil, start] unless template[start] == PROPERTY_TOKEN_START

        token = nil
        pos = start
        filter_start = nil

        while pos < template.size
          case template[pos]
          when PROPERTY_TOKEN_END
            raw_text = template[start..pos]
            filter = nil

            if filter_start.nil?
              property_name = template[start + 1..pos - 1]
            else
              property_name = template[start + 1..filter_start - 1]
              filter = template[filter_start + 1..pos - 1]
            end

            token = PropertyToken.new(raw_text, property_name.to_sym, filter)
            return [token, pos + 1]
          when FILTER_TOKEN_START
            filter_start ||= pos
          end

          pos += 1
        end

        if pos > start
          text = template[start..pos - 1]
          token = TextToken.new(text)
        end

        [token, pos]
      end
    end
  end
end
