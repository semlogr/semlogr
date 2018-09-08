# frozen_string_literal: true

require 'semlogr/enrichers/host'

module Semlogr
  module Enrichers
    describe Host do
      describe '#enrich' do
        let(:log_event) { spy }
        let(:host) { 'foo' }

        subject(:host_enricher) { Host.new }

        before do
          allow(Socket).to receive(:gethostname)
            .and_return(host)
        end

        it 'appends the hostname to the log event' do
          host_enricher.enrich(log_event)

          expect(log_event).to have_received(:add_property_if_absent)
            .with(host: host)
        end
      end
    end
  end
end
