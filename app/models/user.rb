class User < ActiveRecord::Base

  PASSWORD_MIN_LENGTH = 5
  EMAIL_REGEX = /\A[A-Z0-9\._%-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}\z/i

  # Dokumantasyon: Authlogic::ActsAsAuthentic
  # http://rdoc.info/projects/binarylogic/authlogic
  # Module: Authlogic::ActsAsAuthentic::Base::Config
  # Module: Authlogic::ActsAsAuthentic::Password::Config
  acts_as_authentic do |c|
    c.login_field  = :email
    #c.validate_password_field = false #aşağıdaki validation ile hallediyoruz
    c.validate_login_field = false #login field'ı olmamasına rağmen hata mesajlarında çıkıyor, o yüzden buna gerek var. Bunu false yapınca eposta için karakter kontrolü yapmıyor.
    #c.validate_email_field = true
    #c.validates_length_of_password_field_options = {:on => :update, :minimum => 4, :if => :has_no_credentials?}
    c.validates_length_of_password_field_options = {:minimum => PASSWORD_MIN_LENGTH, :if => :password_required?}
    #c.validates_length_of_password_confirmation_field_options = {:on => :update, :minimum => 4, :if => :has_no_credentials?}
    c.validates_length_of_password_confirmation_field_options = {:minimum => PASSWORD_MIN_LENGTH, :if => :password_required?}

    #c.validates_format_of_login_field_options({:with => Authlogic::Regex.login, :message => I18n.t('error_messages.login_invalid', :default => "should use only letters, numbers, spaces, and .-_@ please.")})
    #c.validates_length_of_password_confirmation_field_options = false
    #c.validates_length_of_password_field_options = false
  end

  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name 
                  

  #
  # validations
  #
  validates_presence_of :email
  #validates_format_of :email, :with => EMAIL_REGEX 
  validates_presence_of :password, :if => :password_required?
  validates_presence_of :password_confirmation, :if => :password_required?
  #validates_length_of   :password, :minimum => PASSWORD_MIN_LENGTH, :if => :password_required?
  #validates_length_of   :password_confirmation, :minimum => PASSWORD_MIN_LENGTH, :if => :password_required?
  validates_confirmation_of :password, :if => :password_required?

  named_scope :non_admin, :conditions => {:admin => 0}
  named_scope :admin, :conditions => {:admin => 1}
  named_scope :admins, :conditions => {:admin => 1}
  named_scope :active, :conditions => {:active => 1}
  named_scope :inactive, :conditions => {:active => 0}
  named_scope :suspended, :conditions => {:suspended => 1}
  named_scope :unsuspended, :conditions => {:suspended => 0}

  #before_save :sanitize_inputs
  #after_save :create_member_record
  #before_destroy :dont_delete_admin

  #def dont_delete_admin
  #  if self.admin
  #    self.errors.add_to_base(I18n.t('user.admin_cant_be_deleted'))
  #    return false
  #  end
  #end

  #def sanitize_inputs
  #  self.first_name = Sanitize.clean(self.first_name)
  #  self.last_name = Sanitize.clean(self.last_name)
  #end

  def password_required?
    self.crypted_password.blank? # && self.openid_identifier.blank?
  end

  def admin?
    self.admin
  end

  # Bu method authlogic "magic states" tarafından kullanılıyor
  # http://rdoc.info/rdoc/binarylogic/authlogic/blob/c52993c83479d614a18cc888a0ddc0a25b5afd8e/Authlogic/Session/MagicStates/Config.html
  def active?
    self.active
  end

  # Bu method authlogic "magic states" tarafından kullanılıyor
  # http://rdoc.info/rdoc/binarylogic/authlogic/blob/c52993c83479d614a18cc888a0ddc0a25b5afd8e/Authlogic/Session/MagicStates/Config.html
  # Authlogic'te "suspended" hesaplar için bir kontrol olmadığı için, onun yerine
  # "confirmed?" methodu yardımıyla "confirmed" magic state'ini kullanıyoruz.
  def confirmed?
    !self.suspended?
  end

  # Bu method authlogic "magic states" tarafından kullanılıyor
  # http://rdoc.info/rdoc/binarylogic/authlogic/blob/c52993c83479d614a18cc888a0ddc0a25b5afd8e/Authlogic/Session/MagicStates/Config.html
  #def approved?
  #  true
  #end

  def suspended?
    self.suspended
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def full_name_with_email
    "#{self.first_name || ''} #{self.last_name || ''} (#{self.email})"
  end

  #def self.notify_admins_about_new_registration(user)
  #  self.admins.each do |adm|
  #    begin
  #      UserMailer.deliver_registration_notification(adm, user)
  #    rescue Exception => e
  #      e.log
  #    end
  #  end
  #end

  def send_password_reset_code
    reset_perishable_token!
    UserMailer.deliver_password_reset_code(self)
  end

  def reset_password!(new_pw, new_pw_confirm)
    self.update_password(new_pw, new_pw_confirm)
  end

  def update_password(pw, pw_confirmation)
    if pw.blank? or pw_confirmation.blank?
      self.errors.add("password", I18n.t('activerecord.errors.messages.blank'))
      return false
    elsif pw.size < PASSWORD_MIN_LENGTH
      self.errors.add("password", I18n.t('activerecord.errors.messages.too_short', :count => PASSWORD_MIN_LENGTH))
      return false
    else
      self.update_attributes!(:password => pw, :password_confirmation => pw_confirmation)
      return true
    end
  rescue
    return false
  end

  def active_desc
    if self.active?
      "Aktif"
    else
      "Aktif değil"
    end
  end

  def suspended_desc
    if self.suspended?
      "Durdurulmuş"
    else
      "Kullanımda"
    end
  end

  def name_format
    "#{self.sanitized_first_name.slice(0,1)}#{self.sanitized_last_name}"
  end

  def generate_random_password
    a = ('A'..'Z').to_a + ('a'..'z').to_a + ('1'..'9').to_a
    pw = ""
    8.times do
      pw << a[rand(a.size)]
    end
    self.password = pw
    self.password_confirmation = pw
  end

  def grant_admin_role!
    self.admin = true
    self.save
  end

  def revoke_admin_role!
    self.admin = false
    self.save
  end

  def activate!
    self.update_attribute('active', true)
    self.reset_perishable_token!
  end

  def unactivate!
    self.update_attribute('active', false)
    self.reset_perishable_token!
  end

  def suspend!
    self.update_attribute('suspended', true)
  end

  def unsuspend!
    self.update_attribute('suspended', false)
    self.activate! # Kullanıclar paket alırken hesapları oluşturulduğu için 
  end

  def sanitized_first_name
    self.first_name.gsub(/[^a-z\.]/i,'')
  end

  def sanitized_last_name
    self.last_name.gsub(/[^a-z\.]/i,'')
  end

  def suspended_desc
    self.suspended? ? "Evet" : "Hayır"
  end

  #def deliver_activation_instructions!
  #  reset_perishable_token!
  #  UserMailer.deliver_activation_instructions(self)
  # rescue Exception => e
  #   e.log
  #end

  #def deliver_activation_confirmation!
  #  reset_perishable_token!
  #  UserMailer.deliver_activation_confirmation(self)
  # rescue Exception => e
  #   e.log
  #end

  def role_desc
    self.admin? ? "Yönetici" : "Normal Kullanıcı"
  end

end
