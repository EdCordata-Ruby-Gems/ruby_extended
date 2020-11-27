# frozen_string_literal: true

require 'bigdecimal'
require_relative '../lib/ruby_extended.rb'

RSpec.describe Numeric do


  describe 'Numeric.no_zeros' do

    it 'Should convert BigDecimal to no-zero string' do
      expect(BigDecimal('1.0').no_zeros).to eql('1')
      expect(BigDecimal('1.10').no_zeros).to eql('1.1')
    end

    it 'Should convert Float return to no-zero string' do
      expect(Float('1.0').no_zeros).to eql('1')
      expect(Float('1.10').no_zeros).to eql('1.1')
    end

    it 'Should convert Integer return to no-zero string' do
      expect(Integer('1').no_zeros).to eql('1')
      expect(Integer('1').no_zeros).to eql('1')
    end

    it 'Should convert Complex return to no-zero string' do
      expect(Complex('1.0').no_zeros).to eql('1')
      expect(Complex('1.10').no_zeros).to eql('1.1')
    end

    it 'Should convert Rational return to no-zero string' do
      expect(Rational('1.0').no_zeros).to eql('1')
      expect(Rational('1.10').no_zeros).to eql('1.1')
    end

  end


  describe 'Numeric.to_money' do

    it 'Should convert BigDecimal to string formatted like money' do
      expect(BigDecimal('1.0').to_money).to eql('1.00')
    end

    it 'Should convert Float return to string formatted like money' do
      expect(Float('1.0').to_money).to eql('1.00')
    end

    it 'Should convert Integer return to string formatted like money' do
      expect(Integer('1').to_money).to eql('1.00')
    end

    it 'Should convert Complex return to string formatted like money' do
      expect(Complex('1.0').to_money).to eql('1.00')
    end

    it 'Should convert Rational return to string formatted like money' do
      expect(Rational('1.0').to_money).to eql('1.00')
    end

  end


  describe 'Numeric.percent_of' do

    it 'Should return percentage from BigDecimal value' do
      expect(BigDecimal('1.0').percent_of(BigDecimal('100'))).to eql(1)
    end

    it 'Should return percentage from Float value' do
      expect(Float('1.0').percent_of(Float('100'))).to eql(1)
    end

    it 'Should return percentage from Integer value' do
      expect(Integer('1').percent_of(Integer('100'))).to eql(1)
    end

    it 'Should return percentage from Complex value' do
      expect(Complex('1.0').percent_of(Complex('100'))).to eql(1)
    end

    it 'Should return percentage from Rational value' do
      expect(Rational('1.0').percent_of(Rational('100'))).to eql(1)
    end

  end


  describe 'Numeric.get_percent_from' do

    it 'Should return percent from two numbers, using BigDecimal class' do
      expect(BigDecimal('1.0').get_percent_from(BigDecimal('2'))).to eql(50)
    end

    it 'Should return percent from two numbers, using Float class' do
      expect(Float('1.0').get_percent_from(Float('2'))).to eql(50)
    end

    it 'Should return percent from two numbers, using Integer class' do
      expect(Integer('1').get_percent_from(Integer('2'))).to eql(50)
    end

    it 'Should return percent from two numbers, using Complex class' do
      expect(Complex('1.0').get_percent_from(Complex('2'))).to eql(50)
    end

    it 'Should return percent from two numbers, using Rational class' do
      expect(Rational('1.0').get_percent_from(Rational('2'))).to eql(50)
    end

  end


end
