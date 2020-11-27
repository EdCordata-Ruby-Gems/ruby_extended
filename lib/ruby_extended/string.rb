class String


  def strip_whitespace(options = {})
    res = self
    res = res.gsub("\u0020", '') # SPACE (U+0020)
    res = res.gsub("\u00A0", '') # NO-BREAK SPACE (U+00A0)
    res = res.gsub("\u1680", '') # OGHAM SPACE MARK (U+1680)
    res = res.gsub("\u180E", '') # MONGOLIAN VOWEL SEPARATOR (U+180E)
    res = res.gsub("\u2000", '') # EN QUAD (U+2000)
    res = res.gsub("\u2002", '') # EN SPACE (nut) (U+2002)
    res = res.gsub("\u2003", '') # EM SPACE (mutton) (U+2003)
    res = res.gsub("\u2004", '') # THREE-PER-EM SPACE (thick space) (U+2004)
    res = res.gsub("\u2005", '') # FOUR-PER-EM SPACE (mid space) (U+2005)
    res = res.gsub("\u2006", '') # SIX-PER-EM SPACE (U+2006)
    res = res.gsub("\u2007", '') # FIGURE SPACE (U+2007)
    res = res.gsub("\u2008", '') # PUNCTUATION SPACE (U+2008)
    res = res.gsub("\u2009", '') # THIN SPACE (U+2009)
    res = res.gsub("\u200A", '') # HAIR SPACE (U+200A)
    res = res.gsub("\u200B", '') # ZERO WIDTH SPACE (U+200B)
    res = res.gsub("\u200F", '') # NARROW NO-BREAK SPACE (U+200F)
    res = res.gsub("\u205F", '') # MEDIUM MATHEMATICAL SPACE (U+205F)
    res = res.gsub("\u3000", '') # IDEOGRAPHIC SPACE (U+3000)
    res = res.gsub("\uFEFF", '') # ZERO WIDTH NO-BREAK SPACE (U+FEFF)

    if options[:visible]
      res = res.gsub("\u2423", '') # OPEN BOX (U+2423)
      res = res.gsub("\u2422", '') # BLANK SYMBOL (U+2422)
      res = res.gsub("\u2420", '') # SYMBOL FOR SPACE (U+2420)
    end

    res
  end


  def strip_newline
    res = self
    res = res.delete("\n")
    res = res.delete("\r")
    res
  end


  def index_of(str)
    res = []
    self.scan(/#{str}/) { |c| res << [c, $~.offset(0)[0]] }
    res.map(&:last)
  end


  def similarity_percent(b)
    longer  = [self.size, b.size].max
    same    = self.each_char.zip(b.each_char).select { |a, b| a == b }.size
    percent = (longer - same) / self.size.to_f
    (100.0 - (percent * 100.to_f))
  end


end
