# frozen_string_literal: true

require 'semlogr/templates/property_token'
require 'semlogr/formatters/property_value_formatter'

module Semlogr
  module Templates
    describe PropertyToken do
      describe '#render' do
        let(:token_text) { 'a' }
        let(:property_name) { :a }
        let(:format) { nil }
        let(:token) { PropertyToken.new(token_text, property_name, format) }

        subject do
          output = +''
          token.render(output, properties)
          output
        end

        context 'when property does not exist in properties' do
          let(:properties) { {} }

          it 'returns raw text' do
            is_expected.to eq(token_text)
          end
        end

        context 'when property exists in properties' do
          let(:properties) { { a: 123 } }
          let(:formatted_value) { '123' }

          before do
            allow(Formatters::PropertyValueFormatter).to receive(:format)
              .with(properties[:a])
              .and_return(formatted_value)
          end

          it 'returns formatted property value' do
            is_expected.to eq(formatted_value)
          end
        end

        context 'when property has a format string' do
          let(:properties) { { a: 1 } }
          let(:format) { '%.2f' }

          it 'formats property using format string' do
            is_expected.to eq('1.00')
          end
        end

        context 'when formatting throws' do
          let(:properties) { { a: 1 } }
          let(:format) { '%..' }

          it 'renders property raw text' do
            is_expected.to eq(token_text)
          end
        end
      end

      describe '#==' do
        subject { token1 == token2 }

        context 'when tokens have same text, property name and template' do
          let(:token1) { PropertyToken.new('a', :a, '%.2f') }
          let(:token2) { PropertyToken.new('a', :a, '%.2f') }

          it { is_expected.to eq(true) }
        end

        context 'when tokens do not have same text, property name and token' do
          let(:token1) { PropertyToken.new('a', :a, '%.2f') }
          let(:token2) { PropertyToken.new('b', :b) }

          it { is_expected.to eq(false) }
        end
      end
    end
  end
end
