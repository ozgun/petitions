module PagesHelper

  def page_icon(c_page)
    if c_page and c_page.has_icon?
      c_page.icon.metadata.url
    else
      ""
    end
  end

  # 1) Eğer sayfa bir kategoriye dahilse, sayfanın ismi yerine kategorinin ismi
  # yazsın sidebar başlığında. Örnek: İnternet Reklam kategorisindeki "Banner Reklam"
  # sayfası çağırılmışsa sidebar başlığında "INTERNET REKLAM" yazar.
  #
  # 2) Eğer sayfa herhangi bir kategoriye dahil değilse, sayfanın başlığı yazsın.
  # Örnek: Biz Kimiz sayfası çağırıldığın sidebar başlığında "BİZ KİMİZ" yazar.
  def sidebar_title(c_page)
    s_title =  ""
    if c_page
      if c_page.page_category
          s_title = c_page.page_category.name.upcase_tr 
          if c_page.page_category.menu_description and !c_page.page_category.menu_description.blank?
            s_title << " <span class=\"category_menu_description\">#{c_page.page_category.menu_description}</span>"
          end
      else
        s_title = c_page.title.upcase_tr
      end
    end
    return s_title
  end

end
