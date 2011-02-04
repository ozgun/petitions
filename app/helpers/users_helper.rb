module UsersHelper

  def setup_price_desc_for_user(product)
    out = ""
    if logged_in?
      if current_user.has_account_for?(product) 
        out = number_to_currency(0)
      else 
        out = t('product.setup_price_desc')
      end 
    else 
      out <<  t('product.setup_price_desc')
      out << " <b>#{t('product.setup_price_desc_for_visitiors')}</b>"
    end 
    out
  end
end
