module ObjectRubyExtended


  def self.included(base)
    base.class_eval do

      def dig(*items)
        res, all_items = self, items.flatten

        all_items.each do |item|
          next if res.nil?
          res = res[item] rescue nil
        end

        res
      end

    end
  end


end


class Array
  include ObjectRubyExtended
end


class Hash
  include ObjectRubyExtended
end
