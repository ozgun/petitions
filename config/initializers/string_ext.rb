class String

  def upcase_tr!
    self.gsub!(/i/,'İ')
    self.gsub!(/ı/,'I')
    self.gsub!(/ş/,'Ş')
    self.gsub!(/ğ/,'Ğ')
    self.gsub!(/ü/,'Ü')
    self.gsub!(/ö/,'Ö')
    self.gsub!(/ç/,'Ç')
    self.upcase
  end

  def downcase_tr!
    self.gsub!(/İ/,'i')
    self.gsub!(/I/,'ı')
    self.gsub!(/Ş/,'ş')
    self.gsub!(/Ş/,'ğ')
    self.gsub!(/Ü/,'ü')
    self.gsub!(/Ö/,'ö')
    self.gsub!(/Ç/,'ç')
    self.upcase
  end

  # \r ve \n'leri çıkar
  def flatize_text
    self.gsub("\n", " ").gsub("\r", "")
  end

end
