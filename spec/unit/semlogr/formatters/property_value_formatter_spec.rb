# frozen_string_literal: true

require 'ostruct'
require 'semlogr/formatters/property_value_formatter'

module Semlogr
  module Formatters
    describe PropertyValueFormatter do
      describe '.format' do
        subject do
          output = +''
          PropertyValueFormatter.format(output, value)
          output
        end

        context 'when value is nil' do
          let(:value) { nil }

          it 'returns nil placeholder' do
            is_expected.to eq('(nil)')
          end
        end

        context 'when value is string' do
          let(:value) { 'foo' }

          it 'returns quoted string' do
            is_expected.to eq('"foo"')
          end
        end

        context 'when value is error' do
          let(:backtrace) { nil }
          let(:value) do
            error = StandardError.new('message')
            error.set_backtrace(backtrace)
            error
          end

          context 'when no backtrace present' do
            it 'returns formatter error without backtrace' do
              is_expected.to eq("StandardError: message\n")
            end
          end

          context 'when backtrace is present' do
            let(:backtrace) { ['line 1', 'line 2'] }

            it 'returns formatted error with backtrace' do
              expected = "StandardError: message\n  line 1\n  line 2\n"

              is_expected.to eq(expected)
            end
          end
        end

        context 'when value is object' do
          class TestObject
            def to_s
              'test-object'
            end
          end

          let(:value) { TestObject.new }

          it 'returns to_s of object' do
            is_expected.to eq(TestObject.new.to_s)
          end
        end
      end
    end
  end
end
