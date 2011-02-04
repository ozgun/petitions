class UsersController < ApplicationController

  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if verify_recaptcha(:model => @user, :message => "Lütfen resimde gördüğünüz karakterleri tekrar kontrol ediniz.") and @user.save
      flash[:notice] = t('auth.account_created')
      @user.deliver_activation_instructions!
      redirect_to root_url
    else
      #logger.debug "-----------#{@user.errors.inspect}---------"
      render :action => :new
    end
  end
  
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end
  
  def update
    @user = current_user # makes our views "cleaner" and more consistent
    #unless admin?
    #  # Do not allow nonadmins to update login id(email)
    #  params[:user][:email] = @user.email
    #end
    if @user.update_attributes(params[:user])
      flash[:notice] = t('my_account.updated')
      #redirect_to account_url
      redirect_to my_account_path
    else
      flash.now[:error] = t('my_account.not_updated')
      render :action => :edit
    end
  end

end
