# Ruby Extend - Array



### `.clean`
Cleans Array from empty values
```ruby
['', nil, 'value'].clean # => ['value']
```
Allows to strip string values, before checking if it's empty, with parameter `strip`.
```ruby
['', nil, 'value', ' ', ' a '].clean(strip: true) # => ['value', ' a ']
```
Note that strip, used in this method, is regular ruby `.strip` not
[.strip_whitespace](https://github.com/EdCordata-Ruby-Gems/ruby_extended/blob/master/documentation/string.md#strip_whitespace)
available in this gem.



### `.sort_lv`
Sorts Array respecting latvian characters, like `Ā`, `Č`, etc..
```ruby
%w[a b c ā z č].sort_lv # => ['a', 'ā', 'b', 'c', 'č', 'z']
```
Method accepts block, so it can be used on hash arrays.
```ruby
[
  { n: 'a' },
  { n: 'c' },
  { n: 'ā' },
  { n: 'č' },
  { n: 'z' }
].sort_lv { |x| x[:n] } # => [ { n: 'a' }, { n: 'ā' }, { n: 'c' }, { n: 'č' }, { n: 'z' } ]
```


### `.tabulate`
Split and transpose array horizontally or vertically.
```ruby
%w[a b c d e f g].tabulate(2, split_by: :columns, direction: :horizontal)
# => [ [a,b], [c,d], [e,f], [g,nil] ]
#
# visualized example:
# [ a ] [ b ]
# [ c ] [ d ]
# [ e ] [ f ]
# [ g ] [nil] 
```
```ruby
%w[a b c d e f g].tabulate(2, split_by: :rows, direction: :horizontal)
# => [ [a,b,c,d], [e,f,g,nil] ]
#
# visualized example:
# [ a ] [ b ] [ c ] [ d ]
# [ e ] [ f ] [ g ] [nil] 
```
```ruby
%w[a b c d e f g].tabulate(2, split_by: :columns, direction: :vertical)
# => [ [a,b,c,d], [e,f,g,nil] ]
#
# visualized example:
# [ a ] [ e ]
# [ b ] [ f ]
# [ c ] [ g ]
# [ d ] [nil] 
```
```ruby
%w[a b c d e f g].tabulate(2, split_by: :rows, direction: :vertical)
# => [ [a,c,e,g], [b,d,f,nil] ]
#
# visualized example:
# [ a ] [ c ] [ e ] [ g ]
# [ b ] [ d ] [ f ] [nil]
```


### `.sample_index`
Returns uniq array of hashes, based on one key.
```ruby
[
  {a: 1, b: '123'},
  {a: 1, b: 'abc'},
  {a: 2, b: 'cde'}
].uniq_by_key(:a)   # => [ {a: 1, b: '123'}, {a: 2, b: 'cde'} ]
```
Returns original array if key not found
```ruby
[
  {a: 1, b: '123'},
  {a: 1, b: 'abc'},
  {a: 2, b: 'cde'}
].uniq_by_key(:x)   # => [ {a: 1, b: '123'}, {a: 1, b: 'abc'}, {a: 2, b: 'cde'} ]
```


### `.duplicates`
Returns duplicates from array
```ruby
['a', 'a', 2, 2, 2, 2, 3, 'b', nil, nil].duplicates # => ['a', 2, nil]
```
Returns duplicates from array with count
```ruby
['a', 'a', 2, 2, 2, 2, 3, 'b', nil, nil].duplicates(full: true)
# => [
#       {item: 'a', count: 2},
#       {item: 2,   count: 4},
#       {item: nil, count: 2}
#    ]
```


### `.sum` (overwrites & extends existing method)
```ruby
[1, 2, 3].sum               # => 6
[0.1, 0.2, 1].sum           # => 1.3
%w[a b].sum                 # => 'ab'
['a', 'b', 2, 1.5, nil].sum # => ab21.5
```
If only numbers in array need to be summed:
```ruby
['a', 1, 1.5, nil].sum(only_numbers: true) # => 2.5
```
Possible to sum by hash key:
```ruby
[ {a: 1}, {a: 'a'}, {a: 3} ].sum(key: :a, only_numbers: true) # => 4
[ {a: 1}, {a: 'a'}, {b: 3} ].sum(key: :a, only_numbers: true) # => 1
```
If the key is not found in any of the array hash items, will return `nil`
```ruby
[ {a: 1}, {a: 'a'}, {a: 3} ].sum(key: :b) # => nil
```


### `.to_tree`
Converts hash array with parent_id to embed array with children.
```ruby
[
  {id: 1, parent_id: nil, any_other_key: 'a'},
  {id: 2, parent_id: 1,   any_other_key: 'b'},
  {id: 3, parent_id: 2,   any_other_key: 'c'},
].to_tree
```
to
```json
[                                
  {                              
    "id": 1,                     
    "parent_id": null,           
    "any_other_key": "a",        
    "children": [                
      {                          
        "id": 2,                 
        "parent_id": 1,          
        "any_other_key": "b",    
        "children": [            
          {                      
            "id": 3,             
            "parent_id": 2,      
            "any_other_key": "c" 
          }                      
        ]                        
      }                          
    ]                            
  }                              
]                                
```
It's also possible to convert it to hash
```ruby
[
  {id: 1, parent_id: nil, any_other_key: 'a'},
  {id: 2, parent_id: 1,   any_other_key: 'b'},
  {id: 3, parent_id: 2,   any_other_key: 'c'},
].to_tree(to_hash: true)
```
```json
{
  "1": {
    "id": 1,
    "any_other_key": "a",
    "children": {
      "2": {
        "id": 2,
        "any_other_key": "b",
        "children": {
          "3": {
            "id": 3,
            "any_other_key": "c"
          }
        }
      }
    }
  }
}
```
All available options
<table border="1">
  <thead>
    <tr>
      <td>Option</td>
      <td>Description</td>
      <td>Default</td>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>id_key</td>
      <td>Specify the id key</td>
      <td>id</td>
    </tr>
    <tr>
      <td>parent_id_key</td>
      <td>Specify parent_id key</td>
      <td>parent_id</td>
    </tr>
    <tr>
      <td>children_key</td>
      <td>Specify children key</td>
      <td>children</td>
    </tr>
    <tr>
      <td>include_parent_id</td>
      <td>Include parent_id</td>
      <td>false</td>
    </tr>
    <tr>
      <td>include_empty_children</td>
      <td>includes empty children key if no children present</td>
      <td>false</td>
    </tr>
    <tr>
      <td>to_hash</td>
      <td>Convert to hash instead of array</td>
      <td>false</td>
    </tr>
    <tr>
      <td>include_id</td>
      <td>Include id key when converting to hash</td>
      <td>true</td>
    </tr>
  </tbody>
</table>
