class UserMailer < ActionMailer::Base

  default_url_options[:host] = DEFAULT_HOST
  # normalde user_mailer_helper.rb dosyası oluşmaz. Manual oluşturmak gerekiyor.
  helper "user_mailer"

  # This mail is sent to admins to notify new registrations
  def registration_notification(admin, user)
    setup_email(admin.email)
    subject       "Yeni Üye - #{user.full_name}"
    body          :user => user, :admin => admin
  end

  def password_reset_code(user)
    setup_email(user.email)
    subject       "Şifre Değişikliği"
    body          :user => user
  end

  # Üyelik işlemlerini tamamlaması için kullanıcıya gönderilen aktivasyon mesajı
  def activation_instructions(user)
    setup_email(user.email)
    subject       "Üyelik Aktivasyon Mesajı"
    body          :user => user
  end

  # Aktivasyon tamamlandıktan sorna kullanıcıya mesaj gönder
  def activation_confirmation(user)
    setup_email(user.email)
    subject       "Üyelik aktivasyonuz başarıyla gerçekleşmiştir"
    body          :user => user
  end

  # İletişim formu gönderildiği zaman yöneticilere(admin) mail gönderilir.
  def contact_form_notification(email, contact_form_datum)
    setup_email(email)
    subject   "İletişim Formundan Mesaj Gönderildi! - #{contact_form_datum.created_at}"
    body      :contact_form_datum => contact_form_datum
  end

  def order_confirmation_to_user(user, order, payment, product_form, line_items)
    setup_email(user.email)
    subject   "Sipariş Detayları"
    body      :user => user, :order => order, :payment => payment, :product_form => product_form, :line_items => line_items
  end

  def order_confirmation_to_admin(admin_email, user, order, payment, product_form, line_items)
    setup_email(admin_email)
    subject   "Yeni Sipariş - #{order.created_at}"
    body      :user => user, :order => order, :payment => payment, :product_form => product_form, :line_items => line_items
  end

  # ----------------------------------------------------
  # Helper methods for user mailer 
  # ----------------------------------------------------

  def setup_email(recipient_addr)
    #from          "no_reply <#{SMTP_USER}>" #This generates error!
    from          SMTP_USER
    recipients    recipient_addr
    sent_on       Time.now
    content_type "text/plain" #default
    #content_type  "text/html" #Don't forget to add <br /> tags to the template
    #headers       {}
  end

  def setup_html_email(recipient_addr)
    from          SMTP_USER
    recipients    recipient_addr
    sent_on       Time.now
    #content_type "text/plain" #default
    content_type  "text/html" #Don't forget to add <br /> tags to the template
    #headers       {}
  end
  

end
