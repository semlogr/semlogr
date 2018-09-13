# frozen_string_literal: true

require 'semlogr/sinks/aggregate'

module Semlogr
  module Sinks
    describe Aggregate do
      describe '#emit' do
        let(:log_event) { spy }
        let(:sinks) { [spy, spy] }

        subject(:aggregate_sink) { Aggregate.new(sinks) }

        before do
          aggregate_sink.emit(log_event)
        end

        it 'passes log event to all child sinks' do
          expect(sinks).to all(
            have_received(:emit)
              .with(log_event)
          )
        end

        context 'when child sink throws an error' do
          let(:bad_sink) { spy }

          before do
            sinks << bad_sink

            allow(bad_sink).to receive(:emit)
              .and_raise('boom')
          end

          it 'swallows error and calls remaining child sinks' do
            expect(sinks - [bad_sink]).to all(
              have_received(:emit)
                .with(log_event)
            )
          end
        end
      end
    end
  end
end
