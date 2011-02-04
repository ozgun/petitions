# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  layout :set_layout

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation, :password_new
  helper_method :current_user_session, :current_user, :logged_in?, :admin?, :current_page_title

  #before_filter :set_site_settings
  before_filter :set_page_title

  private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def require_user
    unless current_user
      store_location
      flash[:notice] = "Bu safyaya erişebilmek için lütfen giriş yapınız."
      redirect_to new_user_session_url
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      #flash[:notice] = "You must be logged out to access this page"
      redirect_to root_url
      return false
    end
  end

  def require_admin
    if logged_in? and admin?
      return true
    else
      #flash[:notice] = "Bu sayfaya sadece yöneticiler erişebilir."
      redirect_to root_url
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  def logged_in?
    current_user
  end

  def admin?
    logged_in? and current_user.admin?
  end

  def check_for_admin_pages
    case request.env['REQUEST_URI'] 
    when /\A(\/admin\/?)/
      require_admin
    end
  end

  #Bu aynı zamanda views/partials'da da kullanılmakta.
  def set_layout
    unless request.xhr?
      #logger.debug "-------#{request.env['REQUEST_URI']}-------------"
      case request.env['REQUEST_URI'] 
      when /\A(\/admin\/?)/
        #logger.debug "-----------admin....---------"
        return "admin"
      end
      return "application"
    end
  end
  
  #def set_site_settings
  #  @site_settings = Setting.first
  #  unless @site_settings
  #    @site_settings = Setting.new
  #    @site_settings.save!
  #  end
  #  @site_settings
  #end

  #def site_settings
  #  @site_settings ||= set_site_settings
  #end

  #def home_page?
  #  (params[:controller] == "welcome") and (params[:action] == "index")
  #end

  def set_page_title
    @current_page_title = case request.request_uri
    when /dilekceler/
      t('petitions')
    when /sozlesmeler/
      t('agreements')
    when /diger-yazismalar/
      t('other_documents')
    else
      ""
    end
  end

  def current_page_title
    @current_page_title
  end


end
