# Ruby Extend - Number (Integer, Float, BigDecimal, Complex, Rational)



### `.no_zeros`
Converts any number to string, that has no zeroes
```ruby
(1.0).no_zero  # => '1'
(1.10).no_zero # => '1.1'
```


### `.to_money`
Converts any number to string formatted in money format
```ruby
(1.0).to_money  # => '1.00'
```


### `.percent_of`
Get percent value from number
```ruby
(10).percent_of(100) # => 10
```
Possible to get decimal value as well
```ruby
(10).percent_of(111, decimal: true) # => 11.100000000000001
```


### `.get_percent_from`
Get percent from two numbers
```ruby
(2).get_percent_from(6) # => 33
```
Possible to get decimal value as well
```ruby
(2).get_percent_from(6, decimal: true) # => 33.33333333333333
```
