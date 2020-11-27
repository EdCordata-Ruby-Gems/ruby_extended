# frozen_string_literal: true

require 'bigdecimal'
require_relative '../lib/ruby_extended.rb'

RSpec.describe Array do


  describe 'String.strip_whitespace' do

    it "Expect to remove character SPACE (U+0020)" do
      expect("\u0020".strip_whitespace).to eql('')
    end

    it "Expect to remove character NO-BREAK SPACE (U+00A0)" do
      expect("\u00A0".strip_whitespace).to eql('')
    end

    it "Expect to remove character OGHAM SPACE MARK (U+1680)" do
      expect("\u1680".strip_whitespace).to eql('')
    end

    it "Expect to remove character MONGOLIAN VOWEL SEPARATOR (U+180E)" do
      expect("\u180E".strip_whitespace).to eql('')
    end

    it "Expect to remove character EN QUAD (U+2000)" do
      expect("\u2000".strip_whitespace).to eql('')
    end

    it "Expect to remove character EN SPACE (nut) (U+2002)" do
      expect("\u2002".strip_whitespace).to eql('')
    end

    it "Expect to remove character EM SPACE (mutton) (U+2003)" do
      expect("\u2003".strip_whitespace).to eql('')
    end

    it "Expect to remove character THREE-PER-EM SPACE (thick space) (U+2004)" do
      expect("\u2004".strip_whitespace).to eql('')
    end

    it "Expect to remove character FOUR-PER-EM SPACE (mid space) (U+2005)" do
      expect("\u2005".strip_whitespace).to eql('')
    end

    it "Expect to remove character SIX-PER-EM SPACE (U+2006)" do
      expect("\u2006".strip_whitespace).to eql('')
    end

    it "Expect to remove character FIGURE SPACE (U+2007)" do
      expect("\u2007".strip_whitespace).to eql('')
    end

    it "Expect to remove character PUNCTUATION SPACE (U+2008)" do
      expect("\u2008".strip_whitespace).to eql('')
    end

    it "Expect to remove character THIN SPACE (U+2009)" do
      expect("\u2009".strip_whitespace).to eql('')
    end

    it "Expect to remove character HAIR SPACE (U+200A)" do
      expect("\u200A".strip_whitespace).to eql('')
    end

    it "Expect to remove character ZERO WIDTH SPACE (U+200B)" do
      expect("\u200B".strip_whitespace).to eql('')
    end

    it "Expect to remove character NARROW NO-BREAK SPACE (U+200F)" do
      expect("\u200F".strip_whitespace).to eql('')
    end

    it "Expect to remove character MEDIUM MATHEMATICAL SPACE (U+205F)" do
      expect("\u205F".strip_whitespace).to eql('')
    end

    it "Expect to remove character IDEOGRAPHIC SPACE (U+3000)" do
      expect("\u3000".strip_whitespace).to eql('')
    end

    it "Expect to remove character ZERO WIDTH NO-BREAK SPACE (U+FEFF)" do
      expect("\uFEFF".strip_whitespace).to eql('')
    end

    it "Expect to remove character OPEN BOX (U+2423)" do
      expect("\u2423".strip_whitespace(visible: true)).to eql('')
    end

    it "Expect to remove character BLANK SYMBOL (U+2422)" do
      expect("\u2422".strip_whitespace(visible: true)).to eql('')
    end

    it "Expect to remove character SYMBOL FOR SPACE (U+2420)" do
      expect("\u2420".strip_whitespace(visible: true)).to eql('')
    end

    it 'Should not break string if no whitespace characters are found' do
      expect('').to eql('')
      expect('abc').to eql('abc')
    end

  end


  describe 'String.strip_newline' do

    it 'Should remove new line characters' do
      expect(''.strip_newline).to eql('')
      expect("\n".strip_newline).to eql('')
      expect("\r".strip_newline).to eql('')
    end

    it 'Should not break string if no new line characters are found' do
      expect('').to eql('')
      expect('abc').to eql('abc')
    end

  end


  describe 'String.index_of' do

    it 'Should return array of indexes from string' do
      expect('abc123abc'.index_of('abc')).to eql([0, 6])
    end

    it 'Should return empty array of no indexes found in string' do
      expect('abc123abc'.index_of('x')).to eql([])
    end

  end


  describe 'String.similarity_percentage' do

    it 'Should return percent on how similar are two strings' do
      expect('ab'.similarity_percent('a')).to eql(50.0)
      expect('ab'.similarity_percent('ax')).to eql(50.0)
      expect('abdefghijk'.similarity_percent('abdefghij0')).to eql(90.0)
    end

  end


end
