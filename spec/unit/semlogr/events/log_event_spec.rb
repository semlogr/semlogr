require 'semlogr/events/log_event'
require 'semlogr/templates/parser'

module Semlogr
  module Events
    describe LogEvent do
      let(:severity) { 'INFO' }
      let(:template) { 'template' }
      let(:properties) { { a: 1, b: 2 } }

      subject(:log_event) { LogEvent.new(severity, template, properties) }

      describe '.create' do
        let(:parsed_template) { Templates::Template.new([]) }

        subject(:log_event) { LogEvent.create(severity, template, properties) }

        before do
          allow(Templates::Parser).to receive(:parse)
            .with(template)
            .and_return(parsed_template)
        end

        it 'sets the severity' do
          expect(log_event.severity).to eq(severity)
        end

        it 'sets the parsed template' do
          expect(log_event.template).to eq(parsed_template)
        end

        it 'sets the properties' do
          expect(log_event.properties).to eq(properties)
        end

        context 'when properties contains error' do
          let(:error) { StandardError.new }
          let(:properties) { { a: 1, error: error } }

          it 'sets the error' do
            expect(log_event.error).to eq(error)
          end

          it 'removes error from properties' do
            expect(log_event.properties).to eq(a: 1)
          end
        end
      end

      describe '#get_property' do
        context 'when property does not exist' do
          it 'returns nil' do
            expect(log_event.get_property(:foo)).to eq(nil)
          end
        end

        context 'when property already exists' do
          let(:properties) { { a: 1 } }

          it 'returns the property value' do
            expect(log_event.get_property(:a)).to eq(1)
          end
        end
      end

      describe '#add_property' do
        it 'adds property to log event' do
          log_event.add_property(a: 1)

          expect(log_event.get_property(:a)).to eq(1)
        end
      end

      describe '#add_property_if_absent' do
        context 'when property does not exist' do
          it 'adds property to log event' do
            log_event.add_property_if_absent(a: 1)

            expect(log_event.get_property(:a)).to eq(1)
          end
        end

        context 'when property already exists' do
          let(:properties) { { a: 1 } }

          it 'does not override existing property' do
            log_event.add_property_if_absent(a: 2)

            expect(log_event.get_property(:a)).to eq(1)
          end
        end
      end

      describe '#render' do
        let(:output) { '' }

        before do
          allow(template).to receive(:render)
            .with(output, properties)
            .and_return('rendered')
        end

        it 'renders to output buffer using template' do
          expect(log_event.render(output)).to eq('rendered')
        end
      end
    end
  end
end
