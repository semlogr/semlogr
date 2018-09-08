# frozen_string_literal: true

require 'semlogr/enrichers/event_type'

module Semlogr
  module Enrichers
    describe EventType do
      describe '#enrich' do
        let(:log_event) { spy }
        let(:event_type) { '1234' }

        subject(:property_enricher) { EventType.new }

        before do
          allow(log_event).to receive(:type)
            .and_return(event_type)
        end

        it 'appends the event_type hash to the log event' do
          property_enricher.enrich(log_event)

          expect(log_event).to have_received(:add_property_if_absent)
            .with(event_type: event_type)
        end
      end
    end
  end
end
