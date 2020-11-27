# Ruby Extend - Object (Array & Hash)



### `.dig`
Navigate hash or array without getting error, in case item is not found.
```ruby
{a: {b: 'value'}}.dig(:a, :b) # => 'value'
[{a: [{b: 'value'}]}].dig(0, :a, 0, :b) # => 'value'
```
Note: the difference from the dig method, included from Ruby 2.3, is that
in this version it's possible to use array as value, which is not possible
to do in original dig method.
```ruby
{a: {b: 'value'}}.dig([:a, :b]) # => 'value'
[{a: [{b: 'value'}]}].dig([0, :a, 0, :b]) # => 'value'
```
