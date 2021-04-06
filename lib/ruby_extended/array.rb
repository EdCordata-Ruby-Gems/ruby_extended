class Array
  require 'unicode_utils'


  def clean(strip: false)
    self.map do |item|
      next if item == ''
      next if item.nil?
      next if item.kind_of?(String) && strip && item.strip == ''
      item
    end.compact
  end


  def sort_lv(&block)
    lang = [
      %w[e ē], %w[u ū], %w[i ī], %w[a ā], %w[s š], %w[g ģ], %w[k ķ], %w[l ļ],
      %w[z ž], %w[c č], %w[n ņ], %w[E Ē], %w[U Ū], %w[I I], %w[A Ā], %w[S Š],
      %w[G Ģ], %w[K Ķ], %w[L Ļ], %w[Z Ž], %w[C Č], %w[N Ņ]
    ]

    self.sort_by do |item|
      value = (block_given? ? yield(item) : item)
      lang.each do |en, lv|
        value = UnicodeUtils.downcase(value).gsub(lv, en)
      end
      value
    end
  end


  def tabulate(num, o = {})
    return nil  if num < 1
    return self if num == 1

    split_by  = o.has_key?(:split_by)  ? o[:split_by]  : :columns
    direction = o.has_key?(:direction) ? o[:direction] : :horizontal
    arr, res  = self, []
    i         = (arr.length / num.to_f).round

    if direction == :horizontal
      ii = 0

      if split_by == :columns
        rows  = ( (i == 1)   ? [0] : (0..i - 1).to_a   )
        cells = ( (num == 1) ? [0] : (0..num - 1).to_a )
      end

      if split_by == :rows
        rows  = ( (num == 1) ? [0] : (0..num - 1).to_a )
        cells = ( (i == 1)   ? [0] : (0..i - 1).to_a   )
      end

      rows.each do |row_i|
        cells.each do |cell_i|
          res[row_i]         = [] if res[row_i].nil?
          res[row_i][cell_i] = arr[ii]
          ii                 = ii + 1
        end
      end

      res
    end

    if direction == :vertical

      if split_by == :columns
        (0..(i - 1)).to_a.each do |r_i|
          res[r_i] = (r_i).step(arr.size * 5, i).to_a.slice(0, num).map {|ii| arr[ii]}
        end
      end

      if split_by == :rows
        (0..(num - 1)).to_a.each do |r_i|
          res[r_i] = (r_i).step(arr.length * 5, num).to_a.slice(0, i).map {|ii| arr[ii]}
        end
      end
    end

    res
  end


  def sample_index(count=1, offset: nil)
    indexes = (0..(self.length - 1)).to_a
    indexes = indexes.slice(offset + 1, indexes.length) if offset
    return nil if indexes.nil?
    result = indexes.sample(count)
    result = result.first if count == 1
    result
  end


  def uniq_by_key(key)
    keys, res, found = [], [], false
    self.each do |item|
      found = true if item.has_key?(key)
      next if keys.include?(item[key])
      res << item
      keys << item[key]
    end
    found ? res : self
  end


  def duplicates(options={})
    self.select {|e| self.count(e) > 1}.uniq.map do |v|
      options[:full] ? { item:  v, count: self.count(v) } : v
    end
  end


  def sum(o={})
    res, str = [], false

    self.map do |e|
      ce = o[:key] ? e[o[:key]] : e
      if o[:only_numbers]
        res << ce if ce.is_a?(Numeric)
      else
        str = true if ce.kind_of?(String)
        res << ce unless ce.nil?
      end
    end

    str ? res.join('') : res.reduce(:+)
  end


  def to_tree(o = {})
    o[:id_key]                 = :id        unless o.has_key?(:id_key)
    o[:parent_id_key]          = :parent_id unless o.has_key?(:parent_id_key)
    o[:children_key]           = :children  unless o.has_key?(:children_key)
    o[:include_id]             = true       unless o.has_key?(:include_id)
    o[:include_parent_id]      = false      unless o.has_key?(:include_parent_id)
    o[:include_empty_children] = false      unless o.has_key?(:include_empty_children)
    o[:to_hash]                = false      unless o.has_key?(:to_hash)

    res = Array.to_tree_children_loop(nil, self, o)
    res = Array.to_tree_hash_loop(res, o) if o[:to_hash]
    res
  end


  private


  def self.to_tree_children_loop(parent_id, items, o)
    res = []

    items.select do |n|
      (parent_id ? n[o[:parent_id_key]] == parent_id : n[o[:parent_id_key]].nil?)
    end.each do |item|
      new_item                    = {}

      new_item[o[:id_key]]        = item[o[:id_key]] if o[:to_hash] || o[:include_id]
      new_item[o[:parent_id_key]] = parent_id        if o[:to_hash] || o[:include_parent_id]

      item.keys.reject do |key|
        key == o[:id_key] || key == o[:parent_id_key]
      end.each do |key|
        new_item[key] = item[key]
      end

      children = Array.to_tree_children_loop(item[o[:id_key]], items, o)

      if children.any? || (children.length == 0 && o[:include_empty_children])
        new_item[o[:children_key]] = children
      end

      res << new_item
    end

    res
  end


  def self.to_tree_hash_loop(items, o)
    res = {}

    items.each do |item|
      res     = {}
      id      = item[o[:id_key]]
      res[id] = {}


      res[id][o[:id_key]]        = item[o[:id_key]]        if o[:include_id]
      res[id][o[:parent_id_key]] = item[o[:parent_id_key]] if o[:include_parent_id]

      item.keys.reject do |key|
        (key == o[:id_key] || key == o[:parent_id_key])
      end.each do |key|
        res[id][key] = item[key]
      end

      if item[o[:children_key]]
        res[id][o[:children_key]] = Array.to_tree_hash_loop(item[o[:children_key]], o)
      else
        res[id][o[:children_key]] = [] if o[:include_empty_children]
      end
    end

    res
  end


end
