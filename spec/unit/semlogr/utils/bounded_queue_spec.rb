# frozen_string_literal: true

require 'semlogr/utils/bounded_queue'

module Semlogr
  module Utils
    describe BoundedQueue do
      let(:max_size) { 10 }

      subject { BoundedQueue.new(max_size) }

      describe '#push' do
        context 'when queue is not full' do
          before do
            subject.push(1)
            subject.push(2)
            subject.push(3)
          end

          it 'pushes item to end of queue' do
            expect(subject.pop).to eq(1)
          end
        end

        context 'when queue is full' do
          before do
            max_size.times { subject.push(1) }
          end

          it 'does not add item to the queue' do
            subject.push(2)

            expect(subject.size).to eq(max_size)
            expect(subject.pop_count(subject.size)).not_to include(2)
          end
        end
      end

      describe '#pop_count' do
        before do
          subject.push(1)
          subject.push(2)
          subject.push(3)
        end

        it 'returns n items from queue' do
          items = subject.pop_count(2)
          expect(items).to eq([1, 2])
        end
      end
    end
  end
end
