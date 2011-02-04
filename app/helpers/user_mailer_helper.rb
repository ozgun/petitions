module UserMailerHelper

  def order_details_for_email(order)
    out = ""
    out << "Sipariş Tarihi: #{order.created_at}\n"
    out << "#{t('order.total')}: #{number_to_currency(order.total)}\n"
    out
  end

  def facebook_ad_info_for_email(product_form)
    out = ""
    a = [:website_desc, :title, :description, :countries_desc, :cities_desc, :keywords_desc]
    package_type = "facebook"
    a.each do |item|
      out << t("facebook_package.#{item.to_s}") + ":  #{h(product_form.send(item) || "").flatize_text}"
      out << "\n"
    end 
    out << "#{t('gender')}: #{product_form.gender_one_line_desc}"
    out << "\n"
    out << "#{t('age')}: #{product_form.age_one_line_desc}"
    out << "\n"
    out << "#{t('education.status')}: #{product_form.education_one_line_desc}"
    out << "\n"
    out << "#{t('political.views')}: #{product_form.political_views_one_line_desc}"
    out << "\n"
    out << "#{t('marital_status.status')}: #{product_form.marital_status_one_line_desc}"
    out << "\n"
    out
  end

  def seo_ad_info_for_email(product_form)
    out = ""
    a = [:website, :keywords_desc]
    a.each do |item|
      out << t("seo_package.#{item.to_s}") + ": #{h(product_form.send(item) || "").flatize_text}"
      out << "\n"
    end
    out
  end

  def mynet_ad_info_for_email(product_form)
    out = ""
    a = [:title, :description, :keywords_desc]
    a.each do |item|
      out << t("mynet_package.#{item.to_s}") + ": #{h(product_form.send(item) || "").flatize_text}"
      out << "\n"
    end
    out
  end

  def google_ad_info_for_email(product_form)
    out = ""
    a = [:title, :description1, :description2, :countries_desc, :cities_desc, :keywords_desc]
    a.each do |item|
      out << t("google_package.#{item.to_s}") + ": #{h(@product_form.send(item) || "").flatize_text}"
      out << "\n"
    end
    out
  end

  def invoice_info_for_email(invoice_info)
    out = ""
    a = [:company, :tax_no, :tax_dept, :street_address_desc]
    a.each do |item|
      out << t("invoice_info.#{item.to_s}") + ": #{h(invoice_info.send(item) || "").flatize_text}"
      out << "\n"
    end
    out
  end

  def user_info_for_email(user)
    out = ""
    a = [:full_name, :company_name, :phone, :gsm_no, :email, :website, :address]
    a.each do |item|
      out << t("user.#{item.to_s}") + ": #{h(user.send(item) || "").flatize_text}"
      out << "\n"
    end
    out << "Şifre tanımlama/değişikliği: #{reset_my_password_url}"
    out
  end

  def product_info_for_email(line_items, order)
    out = ""
    line_items.each do |line_item|
      out << "Paket: #{line_item.name}\n"
      out << "#{t('line_item.price')}: #{number_to_currency(line_item.price)}\n"
      out << "#{t('line_item.price_inc_vat')}: #{number_to_currency(line_item.price_inc_vat)}\n"
      out << "#{t('line_item.setup_price')}: #{number_to_currency(line_item.setup_price)}\n"
    end
    out << "#{t('product.total')}: #{number_to_currency(order.total)}\n"
    out
  end

  def bank_info_for_email
    out = ""
    out << Sanitize.clean(Setting.first.bank_info)
    out << "\n"
    out
  end

end
