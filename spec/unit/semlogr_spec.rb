require 'semlogr'
require 'semlogr/null_logger'

describe Semlogr do
  describe '.logger' do
    it 'defaults to null logger' do
      expect(Semlogr.logger).to be_a(Semlogr::NullLogger)
    end
  end
end
