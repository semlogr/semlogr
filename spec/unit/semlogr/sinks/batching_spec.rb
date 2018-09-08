# frozen_string_literal: true

require 'semlogr/sinks/batching'

module Semlogr
  module Sinks
    describe Batching do
      TestSink = Class.new(Semlogr::Sinks::Batching) do
        attr_reader :emitted

        def initialize(opts = {})
          super(opts)

          @emitted = []
        end

        def emit_batch(log_events)
          @emitted << log_events
        end
      end

      let(:flush_interval) { 0.1 }
      let(:batch_size) { 2 }
      let(:queue_max_size) { 10 }

      subject do
        TestSink.new(
          flush_interval: flush_interval,
          batch_size: batch_size,
          queue_max_size: queue_max_size
        )
      end

      describe 'flushing on interval' do
        let(:log_events) { [] }

        before do
          log_events.each { |e| subject.emit(e) }

          sleep flush_interval + flush_interval
        end

        context 'when there are emitted events' do
          let(:log_events) { Array.new(batch_size) { spy } }

          it 'emits the event batch' do
            expect(subject.emitted[0]).to eq(log_events)
          end
        end

        context 'when there are more emitted events than the buffer size' do
          let(:log_events) { Array.new(batch_size + 1) { spy } }

          it 'emits the first event batch' do
            expect(subject.emitted[0]).to eq(log_events[0..batch_size - 1])
          end

          it 'emits the second event batch' do
            expect(subject.emitted[1]).to eq(log_events[batch_size..-1])
          end
        end

        context 'when the queue is already full' do
          let(:log_events) { Array.new(queue_max_size + queue_max_size) { spy } }

          it 'drops any further emitted events' do
            expect(subject.emitted.flatten).to eq(log_events[0..queue_max_size - 1])
          end
        end

        context 'when there are no buffered events' do
          it 'does not emit an empty batch' do
            expect(subject.emitted).to be_empty
          end
        end
      end
    end
  end
end
