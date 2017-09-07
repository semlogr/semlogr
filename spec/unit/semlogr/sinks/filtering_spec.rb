require 'semlogr/sinks/aggregate'

module Semlogr
  module Sinks
    describe Filtering do
      describe '#emit' do
        let(:log_event) { spy }
        let(:sink) { spy }

        subject(:filtering_sink) { Filtering.new(filters, sink) }

        context 'when log event is not filtered' do
          let(:filters) { [->(_) { false }] }

          it 'emits log event to child sink' do
            filtering_sink.emit(log_event)

            expect(sink).to have_received(:emit)
              .with(log_event)
          end
        end

        context 'when log even is filtered' do
          let(:filters) do
            [
              ->(_) { false },
              ->(_) { true }
            ]
          end

          it 'does not emit log event to child sink' do
            filtering_sink.emit(log_event)

            expect(sink).to_not have_received(:emit)
              .with(log_event)
          end
        end
      end
    end
  end
end
