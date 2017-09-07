require 'semlogr/logger'
require 'semlogr/events/log_event'

module Semlogr
  describe Logger do
    [
      [:debug?, LogSeverity::DEBUG, nil, LogSeverity::WARN],
      [:info?, LogSeverity::INFO, LogSeverity::DEBUG, LogSeverity::ERROR],
      [:warn?, LogSeverity::WARN, LogSeverity::DEBUG, LogSeverity::ERROR],
      [:error?, LogSeverity::ERROR, LogSeverity::WARN, LogSeverity::FATAL],
      [:fatal?, LogSeverity::FATAL, LogSeverity::INFO, nil]
    ].each do |method, severity, lower_severity, higher_severity|
      describe "##{method}" do
        let(:logger) { Logger.new(min_severity, nil, nil) }

        subject { logger.send(method) }

        if lower_severity
          context "when min_severity is less than #{severity}" do
            let(:min_severity) { lower_severity }

            it { is_expected.to eq(true) }
          end
        end

        context "when min_severity equals #{severity}" do
          let(:min_severity) { severity }

          it { is_expected.to eq(true) }
        end

        if higher_severity
          context "when min_severity is greater than #{severity}" do
            let(:min_severity) { higher_severity }

            it { is_expected.to eq(false) }
          end
        end
      end
    end

    [
      [:debug, LogSeverity::DEBUG, nil, LogSeverity::WARN],
      [:info, LogSeverity::INFO, LogSeverity::DEBUG, LogSeverity::ERROR],
      [:warn, LogSeverity::WARN, LogSeverity::DEBUG, LogSeverity::ERROR],
      [:error, LogSeverity::ERROR, LogSeverity::WARN, LogSeverity::FATAL],
      [:fatal, LogSeverity::FATAL, LogSeverity::INFO, nil]
    ].each do |method, severity, lower_severity, higher_severity|
      describe "##{method}" do
        let(:enricher) { spy }
        let(:sink) { spy }
        let(:logger) { Logger.new(min_severity, enricher, sink) }
        let(:log_event) { spy }
        let(:template) { 'Logging' }
        let(:properties) { { a: 1, b: 2 } }

        before do
          allow(Events::LogEvent).to receive(:create)
            .with(severity, template, properties)
            .and_return(log_event)

          logger.send(method, template, **properties)
        end

        if lower_severity
          context "when min_severity is less than #{severity}" do
            let(:min_severity) { lower_severity }

            it 'enriches log event and emits to sink' do
              expect(enricher).to have_received(:enrich)
                .with(log_event)
                .ordered

              expect(sink).to have_received(:emit)
                .with(log_event)
                .ordered
            end
          end
        end

        context "when min_severity equals #{severity}" do
          let(:min_severity) { severity }

          it 'enriches log event and emits to sink' do
            expect(enricher).to have_received(:enrich)
              .with(log_event)
              .ordered

            expect(sink).to have_received(:emit)
              .with(log_event)
              .ordered
          end
        end

        if higher_severity
          context "when min_severity is greater than #{severity}" do
            let(:min_severity) { higher_severity }

            it 'does not emit log event to sink' do
              expect(sink).to_not have_received(:emit)
                .with(log_event)
            end
          end
        end
      end
    end
  end
end
