# Ruby Extend - Hash


<br/>


### `.deep_find`
Returns key value in any hash level and return full path to it
```ruby
{
  a: {
    d: 'foo value 1',
    b: [
      {c: 1},
      {d: 'foo value 2'}
    ]
  }
}.deep_find(:d)
# => 
# [
#   {value: 'foo value 1', path: [:a, :d]},
#   {value: 'foo value 2', path: [:a, b, 1, :d]}
# ]
```
