# frozen_string_literal: true

require 'semlogr/templates/template'

module Semlogr
  module Templates
    describe Template do
      describe '#render' do
        let(:output) { +'' }
        let(:text) { 'template' }
        let(:tokens) { [spy, spy] }
        let(:properties) { {} }

        subject { Template.new(text, tokens) }

        before do
          tokens.each_with_index do |_token, i|
            allow(tokens[i]).to receive(:render)
              .with(output, properties) do |output|
                output << "token#{i}"
              end
          end

          subject.render(output, properties)
        end

        it 'renders all tokens to output' do
          expect(output).to eq('token0token1')
        end
      end

      describe '.empty' do
        it 'returns empty template' do
          expect(Template.empty).to eq(Template.new('', [TextToken.empty]))
        end
      end
    end
  end
end
