require 'semlogr/log_severity'

module Semlogr
  describe LogSeverity do
    describe '.create' do
      subject { LogSeverity.create(level) }

      [
        [:debug, LogSeverity::DEBUG],
        [:info, LogSeverity::INFO],
        [:warn, LogSeverity::WARN],
        [:error, LogSeverity::ERROR],
        [:fatal, LogSeverity::FATAL],
        [:foo, LogSeverity::DEBUG]
      ].each do |level, expected|
        context "when severity is :#{level}" do
          let(:level) { level }

          it { is_expected.to eq(expected) }
        end
      end
    end
  end
end
