# frozen_string_literal: true

require 'bigdecimal'
require_relative '../lib/ruby_extended.rb'

RSpec.describe Array do


  describe 'Array.sort_lv' do

    it 'Should order Latvian special characters in array' do
      expect(%w[a b ā c z č].sort_lv).to eql(%w[a ā b c č z])
    end

    it 'Should order Latvian characters in array while accepting block' do
      input_arr  = [ { n: 'a' }, { n: 'c' }, { n: 'ā' }, { n: 'č' }, { n: 'z' } ]
      output_arr = [ { n: 'a' }, { n: 'ā' }, { n: 'c' }, { n: 'č' }, { n: 'z' } ]

      expect(input_arr.sort_lv { |x| x[:n] }).to eql(output_arr)
    end

  end


  describe 'Array.tabulate' do
    input_arr = %w[a b c d e f g]

    it 'Should return nil if tabulate value is 0' do
      expect(input_arr.tabulate(0, split_by: :columns, direction: :horizontal)).to(be_nil)
      expect(input_arr.tabulate(0, split_by: :rows,    direction: :horizontal)).to(be_nil)
      expect(input_arr.tabulate(0, split_by: :columns, direction: :vertical)).to(be_nil)
      expect(input_arr.tabulate(0, split_by: :rows,    direction: :vertical)).to(be_nil)
    end

    it 'Should return nil if tabulate value is bellow 1' do
      expect(input_arr.tabulate(-1, split_by: :columns, direction: :horizontal)).to(be_nil)
      expect(input_arr.tabulate(-1, split_by: :rows,    direction: :horizontal)).to(be_nil)
      expect(input_arr.tabulate(-1, split_by: :columns, direction: :vertical)).to(be_nil)
      expect(input_arr.tabulate(-1, split_by: :rows,    direction: :vertical)).to(be_nil)
    end

    it 'Should convert array to horizontal columns with value 2 (less as input)' do
      output = [ ['a','b'], ['c','d'], ['e','f'], ['g',nil] ]
      expect(input_arr.tabulate(2, split_by: :columns, direction: :horizontal)).to eql(output)
    end

    it 'Should convert array to horizontal rows with value 2 (less as input)' do
      output = [ ['a','b','c','d'], ['e','f','g',nil] ]
      expect(input_arr.tabulate(2, split_by: :rows, direction: :horizontal)).to eql(output)
    end

    it 'Should convert array to vertical columns with value 2 (less as input)' do
      output = [ ['a','e'], ['b','f'], ['c','g'], ['d',nil] ]
      expect(input_arr.tabulate(2, split_by: :columns, direction: :vertical)).to eql(output)
    end

    it 'Should convert array to vertical rows with value 2 (less as input)' do
      output = [ ['a','c','e','g'], ['b','d','f',nil] ]
      expect(input_arr.tabulate(2, split_by: :rows, direction: :vertical)).to eql(output)
    end

    it 'Should convert array to horizontal columns with value 7 (same as input)' do
      output = [ ['a','b','c','d','e','f','g'] ]
      expect(input_arr.tabulate(7, split_by: :columns, direction: :horizontal)).to eql(output)
    end

    it 'Should convert array to horizontal rows with value 7 (same as input)' do
      output = [ ['a'],['b'],['c'],['d'],['e'],['f'],['g'] ]
      expect(input_arr.tabulate(7, split_by: :rows, direction: :horizontal)).to eql(output)
    end

    it 'Should convert array to horizontal columns with value 8 (more than input)' do
      output = [ ['a','b','c','d','e','f','g', nil] ]
      expect(input_arr.tabulate(8, split_by: :columns, direction: :horizontal)).to eql(output)
    end

    it 'Should convert array to horizontal rows with value 8 (more than input)' do
      output = [ ['a'],['b'],['c'],['d'],['e'],['f'],['g'], [nil] ]
      expect(input_arr.tabulate(8, split_by: :rows, direction: :horizontal)).to eql(output)
    end

    it 'Should convert array to horizontal columns with value 9 (more than input)' do
      output = [ ['a','b','c','d','e','f','g', nil, nil] ]
      expect(input_arr.tabulate(9, split_by: :columns, direction: :horizontal)).to eql(output)
    end

    it 'Should convert array to horizontal rows with value 9 (more than input)' do
      output = [ ['a'],['b'],['c'],['d'],['e'],['f'],['g'], [nil], [nil] ]
      expect(input_arr.tabulate(9, split_by: :rows, direction: :horizontal)).to eql(output)
    end

  end


  describe 'Array.sample_index' do
    input_arr = %w[a b c d e f g h]

    it 'Should return random index' do
      expect(input_arr.sample_index(1).class).to be(Integer)

      expect(input_arr.sample_index(1)).to(
        be_between(0, (input_arr.length - 1))
      )
    end

    it 'Should return two random indexes' do
      expect(input_arr.sample_index(2)).to be_instance_of(Array)

      expect(input_arr.sample_index(2).length).to be(2)
    end

  end


  describe 'Array.uniq_by_key' do
    input_arr  = [ {a: 1, b: '123'}, {a: 1, b: 'abc'}, {a: 2, b: 'cde'} ]
    output_arr = [ {a: 1, b: '123'}, {a: 2, b: 'cde'} ]

    it 'Should return uniq hash items' do
      expect(input_arr.uniq_by_key(:a)).to eql(output_arr)
    end

    it 'Should return original array if key not found' do
      expect(input_arr.uniq_by_key(:x)).to eql(input_arr)
    end

  end


  describe 'Array.duplicates' do
    input_arr = ['a', 'a', 2, 2, 2, 2, 3, 'b', nil, nil]

    it 'Should return array of duplicates' do
      expect(input_arr.duplicates).to eql(['a', 2, nil])
    end

    it 'Should return hash with duplicates and count' do
      expect(input_arr.duplicates(full: true)).to(
        eql([
          {item: 'a', count: 2},
          {item: 2,   count: 4},
          {item: nil, count: 2}
        ])
      )
    end

  end


  describe 'Array.sum' do

    it 'Should sum array of integers' do
      expect( [1, 2, 3].sum ).to eq(6)
    end

    it 'Should sum array if floats' do
      expect( [0.1, 0.2, 1].sum ).to eq(1.3)
    end

    it 'Should sum array of integers, floats and strings' do
      expect( %w[a b].sum ).to eq('ab')
      expect( ['a', 'b', 2, 1.5, nil].sum ).to eq('ab21.5')
    end

    it 'Should sum hash by keys' do
      expect( [ {a: 1}, {a: 'a'}, {a: 3} ].sum(key: :a) ).to eq('1a3')
      expect( [ {a: 1}, {a: 'a'}, {b: 3} ].sum(key: :a) ).to eq('1a')
      expect( [ {a: 1}, {a: 2}, {b: 3} ].sum(key: :a) ).to eq(3)
    end

    it 'Should recognize Float, Integer, BigDecimal, Complex and Rational' do
      expect( [BigDecimal(1), Float(1), Integer(1), Complex(1), Rational(1)].sum ).to eq(5)
      expect( [BigDecimal(1), Float(1), Integer(1), Complex(1), Rational(1), 'a'].sum(only_numbers: true) ).to eq(5)
    end

    it 'Should sum only the number values if :only_numbers option provided' do
      expect( ['a', 'b', 5].sum(only_numbers: true) ).to eq(5)
      expect( ['a', 1, 1.5, nil].sum(only_numbers: true) ).to eq(2.5)
    end

    it 'Should sum hash by keys, but only the number values if :only_numbers option provided' do
      expect( [ {a: 1}, {a: 'a'}, {a: 3} ].sum(key: :a, only_numbers: true) ).to eq(4)
      expect( [ {a: 1}, {a: 'a'}, {b: 3} ].sum(key: :a, only_numbers: true) ).to eq(1)
    end

    it 'Should return nil if hash key was not found' do
      expect( [ {a: 1}, {a: 'a'}, {a: 3} ].sum(key: :b) ).to be_nil
    end

  end


  describe 'Array.to_tree' do
    input_arr = [
      {id: 1, parent_id: nil, any_other_key: 'a'},
      {id: 2, parent_id: 1,   any_other_key: 'b'},
      {id: 3, parent_id: 2,   any_other_key: 'c'},
    ]

    input_arr_custom_keys = [
      {id_x: 1, parent_id_x: nil, any_other_key: 'a'},
      {id_x: 2, parent_id_x: 1,   any_other_key: 'b'},
      {id_x: 3, parent_id_x: 2,   any_other_key: 'c'},
    ]

    it 'Should convert array from using parent_id to array, using children sub-array' do
      expect(input_arr.to_tree).to(
        eq([
             {
               id:            1,
               any_other_key: 'a',
               children: [
                   {
                     id: 2,
                     any_other_key: 'b',
                     children: [ {id: 3, any_other_key: 'c'} ]
                   }
                 ]
             }
           ])
      )
    end

    it 'Should convert array from using parent_id to array, using children sub-array but with custom keys' do
      expect(input_arr_custom_keys.to_tree(id_key: :id_x, parent_id_key: :parent_id_x, children_key: :children_x)).to(
        eq([
             {
               id_x:          1,
               any_other_key: 'a',
               children_x: [
                   {
                     id_x:          2,
                     any_other_key: 'b',
                     children_x:  [
                         {id_x: 3, any_other_key: 'c'}
                       ]
                   }
                 ]
             }
           ])
      )
    end

    it 'Should convert array from using parent_id to array, using children sub-array but without id key' do
      expect(input_arr.to_tree(include_id: false)).to(
        eq([
             {
               any_other_key: 'a',
               children: [
                   {
                     any_other_key: 'b',
                     children:  [ {any_other_key: 'c'} ]
                   }
                 ]
             }
           ])
      )
    end

    it 'Should convert array from using parent_id to array, using children sub-array but with parent_id key' do
      expect(input_arr.to_tree(include_parent_id: true)).to(
        eq([
             {
               id:            1,
               any_other_key: 'a',
               parent_id:     nil,
               children: [
                   {
                     id:            2,
                     any_other_key: 'b',
                     parent_id:     1,
                     children:
                       [ {id: 3, any_other_key: 'c', parent_id: 2} ]
                   }
                 ]
             }
           ])
      )
    end

    it 'Should convert array from using parent_id to array, using children sub-array but with empty children key' do
      expect(input_arr.to_tree(include_empty_children: true)).to(
        eq([
             {
               id:            1,
               any_other_key: 'a',
               children:
                 [
                   {
                     id:            2,
                     any_other_key: 'b',
                     children:
                       [ {id: 3, any_other_key: 'c', children: []} ]
                   }
                 ]
             }
           ])
      )
    end

    it 'Should convert array from using parent_id to hash, using children sub-array' do
      expect(input_arr.to_tree(to_hash: true)).to(
        eq({
             1 => {
               id:            1,
               any_other_key: 'a',
               children:      {
                 2 => {
                   id:            2,
                   any_other_key: 'b',
                   children:  {
                     3 => {id: 3, any_other_key: 'c'}
                   }
                 }
               }
             }
           })
      )
    end

    it 'Should convert array from using parent_id to hash, using children sub-array but with custom keys' do
      expect(input_arr_custom_keys.to_tree(to_hash: true, id_key: :id_x, parent_id_key: :parent_id_x, children_key: :children_x)).to(
        eq({
             1 => {
               id_x:          1,
               any_other_key: 'a',
               children_x:    {
                 2 => {
                   id_x:          2,
                   any_other_key: 'b',
                   children_x: {
                       3 => {id_x: 3, any_other_key: 'c'}
                     }
                 }
               }
             }
           })
      )
    end

    it 'Should convert array from using parent_id to hash, using children sub-array but without id key' do
      expect(input_arr.to_tree(to_hash: true, include_id: false)).to(
        eq({
             1 => {
               any_other_key: 'a',
               children: {
                 2 => {
                   any_other_key: 'b',
                   children: {
                       3 => {any_other_key: 'c'}
                     }
                 }
               }
             }
           })
      )
    end

    it 'Should convert array from using parent_id to hash, using children sub-array but with parent_id key' do
      expect(input_arr.to_tree(to_hash: true, include_parent_id: true)).to(
        eq({
             1 => {
               id:            1,
               any_other_key: 'a',
               parent_id:     nil,
               children:      {
                 2 => {
                   id:            2,
                   any_other_key: 'b',
                   parent_id:     1,
                   children:   {
                       3 => {
                           id:            3,
                           any_other_key: 'c',
                           parent_id:     2
                         }
                     }
                 }
               }
             }
           })
      )
    end

    it 'Should convert array from using parent_id to hash, using children sub-array but with empty children key' do
      expect(input_arr.to_tree(to_hash: true, include_empty_children: true)).to(
        eq({
             1 => {
               id:            1,
               any_other_key: 'a',
               children:      {
                 2 => {
                   id:            2,
                   any_other_key: 'b',
                   children: {
                       3 => {
                           id:            3,
                           any_other_key: 'c',
                           children:      {}
                         }
                     }
                 }
               }
             }
           })
      )
    end

  end


end
