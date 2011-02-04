module Admin::DocumentsHelper

  def section_name(section_identifier)
    out = "Tüm Belgeler"
    if section_identifier
      sn = Category::SECTIONS.select{|x| x[1] == section_identifier}
      unless sn.empty? 
        out = sn[0][0]
      end
    end
    out
  end

end
