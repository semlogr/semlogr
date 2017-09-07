require 'semlogr/enrichers/log_context'
require 'semlogr/context/log_context'

module Semlogr
  module Enrichers
    describe LogContext do
      describe '#enrich' do
        let(:log_event) { spy }
        let(:log_context_enricher) { LogContext.new }
        let(:log_context) { [{ a: 1 }, { b: 2 }] }

        before do
          allow(Context::LogContext).to receive(:current)
            .and_return(log_context)
        end

        it 'appends the log context properties to the log event' do
          log_context_enricher.enrich(log_event)

          log_context.each do |p|
            expect(log_event).to have_received(:add_property_if_absent)
              .with(p)
              .ordered
          end
        end
      end
    end
  end
end
