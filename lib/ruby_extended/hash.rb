class Hash


  def deep_find(find_key)
    Hash.deep_find_loop(self, [], find_key).flatten
  end


  private


  def self.deep_find_loop(object, path, find_key)
    found = []

    if object.is_a?(Array)
      object.each_with_index do |sub_object, index|
        found << Hash.deep_find_loop(sub_object, path + [index], find_key)
      end
    elsif object.is_a?(Hash)
      object.keys.each do |key|
        found << {value: object[key], path: path + [key]} if key == find_key
        found << Hash.deep_find_loop(object[key], path + [key], find_key)
      end
    end

    found
  end


end
