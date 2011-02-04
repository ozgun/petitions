class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:destroy]
  
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      user = User.find_by_email(params[:user_session][:email])
      flash[:notice] = "#{t('welcome')}, #{user.email}!"
      if user.admin?
        redirect_to admin_documents_path
      else
        redirect_to root_path
      end
    else
      flash.now[:error] = t('auth.access_denied')
      render :action => :new
    end
  end
  
  def destroy
    current_user_session.destroy
    flash[:notice] = t('auth.logout_ok')
    redirect_to root_url 
  end
end
