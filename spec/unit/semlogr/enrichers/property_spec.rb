require 'semlogr/enrichers/property'

module Semlogr
  module Enrichers
    describe Host do
      describe '#enrich' do
        let(:log_event) { spy }
        let(:properties) { { a: 1, b: 2 } }

        subject(:property_enricher) { Property.new(properties) }

        it 'appends the properties to the log event' do
          property_enricher.enrich(log_event)

          expect(log_event).to have_received(:add_property_if_absent)
            .with(properties)
        end
      end
    end
  end
end
