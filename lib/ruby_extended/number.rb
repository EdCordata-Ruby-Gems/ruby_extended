module NumericRubyExtended


  def self.included(base)
    base.class_eval do

      def no_zeros
        self.to_f.to_s.gsub(/\.0+$/, '')
      end

      def to_money
        '%.2f' % self.to_f
      end

      def percent_of(percent, options = {})
        result = (self.to_f / 100.to_f * percent.to_f)
        options[:decimal] ? result : result.to_i
      end

      def get_percent_from(value, options = {})
        result = (self.to_f / value.to_f * 100)
        options[:decimal] ? result : result.to_i
      end

    end
  end


end


class Integer
  include NumericRubyExtended
end


class Float
  include NumericRubyExtended
end


class BigDecimal
  include NumericRubyExtended
end


class Complex
  include NumericRubyExtended
end


class Rational
  include NumericRubyExtended
end
