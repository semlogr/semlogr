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

        it 'enriches log_event' do
          enrichers.each do |enricher|
            expect(enricher).to have_received(:enrich)
              .with(log_event)
          end
        end

        it 'calls child sink' do
          expect(sink).to have_received(:emit)
            .with(log_event)
        end
      end
    end
  end
end
