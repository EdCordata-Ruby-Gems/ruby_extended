# frozen_string_literal: true

require 'bigdecimal'
require_relative '../lib/ruby_extended.rb'

RSpec.describe Hash do


  describe 'Hash.deep_find' do
    input_hash = {
      a: 1,
      b: {c: {d: 2}},
      e: [{f: 3, g: {h: 4}}]
    }

    it 'Should handle nil value' do
      expect({a: nil}.deep_find(:b)).to eql([])
    end

    it 'Should find in all levels' do
      expect(input_hash.deep_find(:a)).to eql([{:path => [:a], :value => 1}])
      expect(input_hash.deep_find(:b)).to eql([{:path => [:b], :value => {c: {d: 2}}}])
      expect(input_hash.deep_find(:c)).to eql([{:path => [:b, :c], :value => {d: 2}}])
      expect(input_hash.deep_find(:d)).to eql([{:path => [:b, :c, :d], :value => 2}])
      expect(input_hash.deep_find(:e)).to eql([{:path => [:e], :value => [{f: 3, g: {h: 4}}]}])
    end

    it 'Should find in arrays' do
      expect(input_hash.deep_find(:f)).to eql([{:path => [:e, 0, :f], :value => 3}])
      expect(input_hash.deep_find(:g)).to eql([{:path => [:e, 0, :g], :value => {h: 4}}])
      expect(input_hash.deep_find(:h)).to eql([{:path => [:e, 0, :g, :h], :value => 4}])
    end

  end


end
