# frozen_string_literal: true

require 'bigdecimal'
require_relative '../lib/ruby_extended.rb'

RSpec.describe Object do


  describe 'Object.dig' do
    input_hash = {
      a: 1,
      b: {c: {d: 2}},
      e: [{f: 3, g: {h: 4}}],
      i: '123abc',
      j: 123
    }

    input_array = [
      {a: [{b: [1]}], b: [2], c: '123abc', d: 123 }
    ]

    it 'Should find in Hash' do
      expect(input_hash.dig(:a)).to eql(1)
      expect(input_hash.dig(:b, :c)).to eql({d: 2})
      expect(input_hash.dig(:b, :c, :d)).to eql(2)
      expect(input_hash.dig(:i)).to eql('123abc')
      expect(input_hash.dig(:j)).to eql(123)
    end

    it 'Should find in Hash by passing array' do
      expect(input_hash.dig([:a])).to eql(1)
      expect(input_hash.dig([:b, :c])).to eql({d: 2})
      expect(input_hash.dig([:b, :c, :d])).to eql(2)
    end

    it 'Should find in Array' do
      expect(input_array.dig(0, :a, 0, :b, 0)).to eql(1)
      expect(input_array.dig(0, :c)).to eql('123abc')
      expect(input_array.dig(0, :d)).to eql(123)
    end

    it 'Should find in Array by passing array' do
      expect(input_array.dig([0, :a, 0, :b, 0])).to eql(1)
    end

  end


end
