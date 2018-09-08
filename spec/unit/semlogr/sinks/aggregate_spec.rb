# frozen_string_literal: true

require 'semlogr/sinks/aggregate'

module Semlogr
  module Sinks
    describe Aggregate do
      describe '#emit' do
        let(:log_event) { spy }
        let(:sinks) { [spy, spy] }

        subject(:aggregate_sink) { Aggregate.new(sinks) }

        it 'passes log event to all child sinks' do
          aggregate_sink.emit(log_event)

          sinks.each do |sink|
            expect(sink).to have_received(:emit)
              .with(log_event)
          end
        end
      end
    end
  end
end
