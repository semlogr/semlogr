# frozen_string_literal: true

require 'ostruct'
require 'semlogr/formatters/property_value_formatter'

module Semlogr
  module Formatters
    describe PropertyValueFormatter do
      describe '.format' do
        let(:format) { nil }

        subject do
          PropertyValueFormatter.format(value, format)
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

        context 'when format string specified' do
          let(:value) { 1 }
          let(:format) { '.2f' }

          it 'formats property using format string' do
            is_expected.to eq('1.00')
          end
        end

        [
          { value: Date.today, format: '%m/%d/%y' },
          { value: Time.now, format: '%m/%d/%Y' },
          { value: DateTime.now, format: '%m/%d/%Y' }
        ].each do |t|
          context "when value is #{t[:value].class} with format string specified" do
            let(:value) { t[:value] }
            let(:format) { t[:format] }

            it "formats #{t[:value].class} using format string" do
              is_expected.to eq(value.strftime(t[:format]))
            end
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
