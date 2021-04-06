# Ruby Extend - String


<br/>


### `.similarity_percent`
Returns percentage on how similar are two strings
```ruby
'ab'.similarity_percent('a')                  # => 50.0
'ab'.similarity_percent('ax')                 # => 50.0
'abdefghijk'.similarity_percent('abdefghij0') # => 90.0

a = 'The quick brown fox jumps over the lazy dog'
b = 'The quick brown fox jumps over the lazy cat'
a.similarity_percent(b) # => 93.02325581395348
```


<br/>


### `.index_of`
Return array of indexes found in string
```ruby
'abc123abc'.index_of('abc') # => [0, 6]
```


<br/>


### `.strip_newline`
Remove new line characters
```ruby
"\n\r".strip_newline # => ''
```


<br/>


### `.strip_whitespace`
Remove multiple different whitespace characters
```ruby
' '.strip_whitespace # => ''
```
Whitespace characters that are removed:
<table border="1">
  <thead>
    <tr>
      <th>Name</th>
      <th>Code</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>SPACE</td>
      <td>(U+0020)</td>
    <tr>
    <tr>
      <td>NO-BREAK SPACE</td>
      <td>(U+00A0)</td>
    <tr>
    <tr>
      <td>OGHAM SPACE MARK</td>
      <td>(U+1680)</td>
    <tr>
    <tr>
      <td>MONGOLIAN VOWEL SEPARATOR</td>
      <td>(U+180E)</td>
    <tr>
    <tr>
      <td>EN QUAD</td>
      <td>(U+2000)</td>
    <tr>
    <tr>
      <td>EN SPACE (nut)</td>
      <td>(U+2002)</td>
    <tr>
    <tr>
      <td>EM SPACE (mutton)</td>
      <td>(U+2003)</td>
    <tr>
    <tr>
      <td>THREE-PER-EM SPACE (thick space)</td>
      <td>(U+2004)</td>
    <tr>
    <tr>
      <td>FOUR-PER-EM SPACE (mid space)</td>
      <td>(U+2005)</td>
    <tr>
    <tr>
      <td>SIX-PER-EM SPACE</td>
      <td>(U+2006)</td>
    <tr>
    <tr>
      <td>FIGURE SPACE</td>
      <td>(U+2007)</td>
    <tr>
    <tr>
      <td>PUNCTUATION SPACE</td>
      <td>(U+2008)</td>
    <tr>
    <tr>
      <td>THIN SPACE</td>
      <td>(U+2009)</td>
    <tr>
    <tr>
      <td>HAIR SPACE</td>
      <td>(U+200A)</td>
    <tr>
    <tr>
      <td>ZERO WIDTH SPACE</td>
      <td>(U+200B)</td>
    <tr>
    <tr>
      <td>NARROW NO-BREAK SPACE</td>
      <td>(U+200F)</td>
    <tr>
    <tr>
      <td>MEDIUM MATHEMATICAL SPACE</td>
      <td>(U+205F)</td>
    <tr>
    <tr>
      <td>IDEOGRAPHIC SPACE</td>
      <td>(U+3000)</td>
    <tr>
    <tr>
      <td>ZERO WIDTH NO-BREAK SPACE</td>
      <td>(U+FEFF)</td>
    <tr>
  </tbody>
</table>

Possible to also remove visual space characters, by
passing `visible` option.
```ruby
'␣'.strip_whitespace(visible: true) # => ''
```
Visual characters removed
<table>
  <thead>
    <tr>
      <td>Name</td>
      <td>Code</td>
      <td>Character</td>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>OPEN BOX</td>
      <td>U+2423</td>
      <td>␣</td>
    </tr>
    <tr>
      <td>BLANK SYMBOL</td>
      <td>U+2422</td>
      <td>␢</td>
    </tr>
    <tr>
      <td>SYMBOL FOR SPACE</td>
      <td>U+2420</td>
      <td>␠</td>
    </tr>
  </tbody>
</table>
