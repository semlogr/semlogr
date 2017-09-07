require 'semlogr/enrichers/thread'

module Semlogr
  module Enrichers
    describe Thread do
      describe '#enrich' do
        let(:log_event) { spy }

        subject(:thread_enricher) { Thread.new }

        it 'appends the thread id to the log event' do
          thread_enricher.enrich(log_event)

          expect(log_event).to have_received(:add_property_if_absent)
            .with(thread_id: ::Thread.current.object_id)
        end
      end
    end
  end
end
