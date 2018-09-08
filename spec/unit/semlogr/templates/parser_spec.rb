# frozen_string_literal: true

require 'semlogr/templates/parser'

module Semlogr
  module Templates
    describe Parser do
      describe '.parse' do
        subject { Parser.parse(template) }

        context 'when template is empty' do
          let(:template) { '' }

          it 'sets text to the template' do
            expect(subject.text).to eq(template)
          end

          it 'contains an empty token' do
            expect(subject.tokens).to match_array(
              [
                TextToken::EMPTY
              ]
            )
          end
        end

        context 'when template is nil' do
          let(:template) { nil }

          it 'sets text to the template' do
            expect(subject.text).to eq('')
          end

          it 'contains an empty token' do
            expect(subject.tokens).to match_array(
              [
                TextToken::EMPTY
              ]
            )
          end
        end

        context 'when template has only text' do
          let(:template) { 'this is some text' }

          it 'sets text to the template' do
            expect(subject.text).to eq(template)
          end

          it 'contains the text token' do
            expect(subject.tokens).to match_array(
              [
                TextToken.new('this is some text')
              ]
            )
          end
        end

        context 'when template has a single property' do
          let(:template) { '{foo}' }

          it 'sets text to the template' do
            expect(subject.text).to eq(template)
          end

          it 'contains the property token' do
            expect(subject.tokens).to match_array(
              [
                PropertyToken.new('{foo}', :foo)
              ]
            )
          end
        end

        context 'when template has both text and property' do
          let(:template) { 'hello there {foo}' }

          it 'sets text to the template' do
            expect(subject.text).to eq(template)
          end

          it 'contains the text and property token' do
            expect(subject.tokens).to match_array(
              [
                TextToken.new('hello there '),
                PropertyToken.new('{foo}', :foo)
              ]
            )
          end
        end

        context 'when template has multiple properties surrounded by text' do
          let(:template) { 'hello there {foo}, something something: {bah}. More text' }

          it 'sets text to the template' do
            expect(subject.text).to eq(template)
          end

          it 'contains the text and property tokens' do
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

        context 'when template has an unclosed property' do
          let(:template) { 'hello there {foo' }

          it 'sets text to the template' do
            expect(subject.text).to eq(template)
          end

          it 'contains the text tokens' do
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
  end
end
