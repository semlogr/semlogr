require 'semlogr/log_context'

module Semlogr
  module Context
    describe LogContext do
      describe '.current' do
        context 'when there is no current context' do
          it 'returns a new context' do
            context = LogContext.current

            expect(context).to eq([])
          end
        end

        context 'when there is an existing context' do
          it 'returns the existing context' do
            first = LogContext.current
            current = LogContext.current

            expect(first).to be(current)
          end
        end

        context 'when there are multiple threads' do
          it 'returns a unique context for each thread' do
            context1 = nil
            context2 = nil

            t1 = Thread.new do
              context1 = LogContext.current
            end

            t2 = Thread.new do
              context2 = LogContext.current
            end

            t1.join
            t2.join

            expect(context1).to_not be(context2)
          end
        end
      end

      describe '.push_property' do
        context 'when pushing a single property' do
          it 'contains the property only during block execution' do
            LogContext.push_property(a: 1) do
              expect(LogContext.current.last).to eq(a: 1)
            end

            expect(LogContext.current.last).to eq(nil)
          end
        end

        context 'when pushing nested properties' do
          it 'contains the property only during block execution' do
            LogContext.push_property(a: 1) do
              expect(LogContext.current.last).to eq(a: 1)

              LogContext.push_property(b: 2) do
                expect(LogContext.current.last).to eq(b: 2)
              end

              expect(LogContext.current.last).to eq(a: 1)
            end

            expect(LogContext.current.first).to eq(nil)
          end
        end
      end

      describe '.get_property' do
        context 'when property does not exist' do
          it 'return nil' do
            expect(LogContext.get_property(:foo)).to be_nil
          end
        end

        context 'when single property is pushed' do
          it 'returns the property value' do
            LogContext.push_property(foo: 1) do
              expect(LogContext.get_property(:foo)).to eq(1)
            end
          end
        end

        context 'when property is pushed multiple times' do
          it 'returns the latest property value' do
            LogContext.push_property(foo: 1) do
              LogContext.push_property(foo: 2) do
                expect(LogContext.get_property(:foo)).to eq(2)
              end
            end
          end
        end
      end
    end
  end
end
