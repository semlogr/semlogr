require 'semlogr/templates/parser'

include Semlogr::Templates

describe Parser do
  describe '.parse' do
    subject { Parser.parse(template) }

    context 'empty template' do
      let(:template) { '' }

      it 'should contain the expected tokens' do
        expect(subject.tokens).to match_array(
          [
            TextToken::EMPTY
          ]
        )
      end
    end

    context 'nil template' do
      let(:template) { nil }

      it 'should contain the expected tokens' do
        expect(subject.tokens).to match_array(
          [
            TextToken::EMPTY
          ]
        )
      end
    end

    context 'template with only text' do
      let(:template) { 'this is some text' }

      it 'should contain the expected tokens' do
        expect(subject.tokens).to match_array(
          [
            TextToken.new('this is some text')
          ]
        )
      end
    end

    context 'template with single property' do
      let(:template) { '{foo}' }

      it 'should contain the expected tokens' do
        expect(subject.tokens).to match_array(
          [
            PropertyToken.new('{foo}', :foo)
          ]
        )
      end
    end

    context 'template with text and property' do
      let(:template) { 'hello there {foo}' }

      it 'should contain the expected tokens' do
        expect(subject.tokens).to match_array(
          [
            TextToken.new('hello there '),
            PropertyToken.new('{foo}', :foo)
          ]
        )
      end
    end

    context 'template with multiple properties surrounded by text' do
      let(:template) { 'hello there {foo}, something something: {bah}. More text' }

      it 'should contain the expected tokens' do
        expect(subject.tokens).to match_array(
          [
            TextToken.new('hello there '),
            PropertyToken.new('{foo}', :foo),
            TextToken.new(', something something: '),
            PropertyToken.new('{bah}', :bah),
            TextToken.new('. More text')
          ]
        )
      end
    end

    context 'template with unclosed property' do
      let(:template) { 'hello there {foo' }

      it 'should contain the expected tokens' do
        expect(subject.tokens).to match_array(
          [
            TextToken.new('hello there '),
            TextToken.new('{foo')
          ]
        )
      end
    end
  end
end
