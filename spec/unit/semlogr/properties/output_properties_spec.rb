# frozen_string_literal: true

require 'semlogr/properties/output_properties'

module Semlogr
  module Properties
    describe OutputProperties do
      describe '.create' do
        let(:error) { nil }
        let(:properties) { { a: 1, b: 2 } }

        let(:log_event) do
          spy('log-event', severity: 'INFO', timestamp: Time.now, error: error, properties: properties)
        end

        subject { OutputProperties.create(log_event) }

        it { is_expected.to include(timestamp: log_event.timestamp) }
        it { is_expected.to include(severity: log_event.severity) }
        it { is_expected.to include(properties) }
        it { is_expected.to_not include(:error) }

        context 'when timestamp exists in properties' do
          let(:properties) { { timestamp: 'foo' } }

          it 'overrides timestamp with log event timestamp' do
            is_expected.to include(timestamp: log_event.timestamp)
          end
        end

        context 'when severity exists in properties' do
          let(:properties) { { severity: 'foo' } }

          it 'overrides severity with log event severity' do
            is_expected.to include(severity: log_event.severity)
          end
        end

        context 'when log event has error' do
          let(:error) { StandardError.new }

          it { is_expected.to include(error: log_event.error) }

          context 'when error exists in properties' do
            let(:properties) { { error: 'foo' } }

            it 'overrides error with log event error' do
              is_expected.to include(error: log_event.error)
            end
          end
        end
      end
    end
  end
end
