require 'semlogr/enrichers/aggregate'

module Semlogr
  module Enrichers
    describe Aggregate do
      describe '#enrich' do
        let(:log_event) { spy }
        let(:enrichers) { [spy, spy] }

        subject(:aggregate_enricher) { Aggregate.new(enrichers) }

        it 'passes log event to all child enrichers' do
          aggregate_enricher.enrich(log_event)

          enrichers.each do |enricher|
            expect(enricher).to have_received(:enrich)
              .with(log_event)
          end
        end
      end
    end
  end
end
