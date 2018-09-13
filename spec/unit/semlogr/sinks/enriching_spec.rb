# frozen_string_literal: true

require 'semlogr/sinks/enriching'

module Semlogr
  module Sinks
    describe Enriching do
      describe '#emit' do
        let(:log_event) { spy }
        let(:enrichers) { [spy, spy] }
        let(:sink) { spy }

        subject(:enriching_sink) { Enriching.new(enrichers, sink) }

        before do
          enriching_sink.emit(log_event)
        end

        it 'enriches the log event' do
          expect(enrichers).to all(
            have_received(:enrich)
              .with(log_event)
          )
        end

        it 'calls child sink' do
          expect(sink).to have_received(:emit)
            .with(log_event)
        end

        context 'when enricher throws error' do
          let(:bad_enricher) { spy }

          before do
            enrichers << bad_enricher

            allow(bad_enricher).to receive(:enrich)
              .and_raise('boom')
          end

          it 'swallows error and calls remaining enrichers' do
            expect(enrichers - [bad_enricher]).to all(
              have_received(:enrich)
                .with(log_event)
            )
          end
        end
      end
    end
  end
end
