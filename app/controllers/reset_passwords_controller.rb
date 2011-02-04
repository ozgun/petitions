class ResetPasswordsController < ApplicationController
  before_filter :require_no_user
  before_filter :load_user_using_perishable_token, :only => [:edit, :update]

  def new
  end

  def create
    user = User.active.unsuspended.find :first, :conditions => ["email = ?", params[:email]]
    if user
      begin
        user.send_password_reset_code
        #@mail_sent = true
        flash[:notice] = t('auth.password_reset_instructions_sent') + ": #{user.email}."
        redirect_to :action => "new"
      rescue Exception => e
        e.log
        flash.now[:error] = t('auth.password_reset_instructions_not_sent')
        render :action => "new"
      end
    else
      flash.now[:error] = t('auth.password_reset_user_not_found')
      render :action => "new"
    end
    #respond_to do |format|
    #  format.js
    #end
  end

  def edit
  end

  # Şifreyi değiştir ve kullanıcıyı login yap.
  def update
    if @user.reset_password!(params[:user][:password], 
                             params[:user][:password_confirmation])
      flash[:notice] = t('auth.password_updated')  
      redirect_to account_url
      #redirect_to login_path
    else
      flash.now[:error] = t('auth.password_not_updated')
      render :action => :edit  
    end
  end 

  private

  def load_user_using_perishable_token
    # Note that, inactive users won't be able to log in. So we don't need to
    # check it here.
    @user = User.find_by_perishable_token(params[:id])  
    unless @user  
      flash[:notice] = t('auth.password_reset_user_not_found')
      redirect_to :action => "new"
    end
  end


end
