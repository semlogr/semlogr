require 'semlogr/templates/text_token'

module Semlogr
  module Templates
    describe TextToken do
      describe '#render' do
        let(:token_text) { 'a' }
        let(:token) { TextToken.new(token_text) }

        subject do
          output = ''
          token.render(output, nil)
          output
        end

        it { is_expected.to eq(token_text) }
      end

      describe '#==' do
        subject { token1 == token2 }

        context 'when tokens have the same text' do
          let(:token1) { TextToken.new('a') }
          let(:token2) { TextToken.new('a') }

          it { is_expected.to eq(true) }
        end

        context 'when tokens have different text' do
          let(:token1) { TextToken.new('a') }
          let(:token2) { TextToken.new('b') }

          it { is_expected.to eq(false) }
        end
      end
    end
  end
end
