# frozen_string_literal: true

require 'semlogr/self_logger'
require 'timecop'

module Semlogr
  describe SelfLogger do
    describe '#write' do
      let(:log) { spy }
      let(:now) { Time.now }

      before do
        Timecop.freeze(now)

        SelfLogger.logger = log
      end

      after do
        Timecop.return

        SelfLogger.logger = nil
      end

      %i[debug info warn error fatal].each do |severity|
        context 'without error' do
          before do
            SelfLogger.send(severity, 'foo')
          end

          it 'writes message to log' do
            expect(log).to have_received(:<<)
              .with("[#{now.iso8601(3)}] #{severity.upcase}: foo\n")
          end
        end

        context 'with error' do
          let(:error) do
            error = StandardError.new('foo')
            error.set_backtrace(caller)
            error
          end

          before do
            SelfLogger.send(severity, 'foo', error)
          end

          it 'writes message and error to log' do
            expected = <<~MESSAGE
              [#{now.iso8601(3)}] #{severity.upcase}: foo
              StandardError: foo
              \s\s#{error.backtrace.join("\n\s\s")}
            MESSAGE

            expect(log).to have_received(:<<)
              .with(expected)
          end
        end
      end
    end
  end
end
