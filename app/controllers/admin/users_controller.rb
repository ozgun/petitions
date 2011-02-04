class Admin::UsersController < ApplicationController
  before_filter :require_admin
  before_filter :find_user, :only => [:show, :edit, :update, :suspend, :unsuspend, :destroy]

  def index
    unless params[:search]
      params[:search] = {:order => "ascend_by_first_name"}
    end
    @search = User.search(params[:search])
    @users, @user_count = @search.paginate(:page => params[:page], :per_page => 20), @search.count
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      @user.activate!
      flash[:notice] = t('item.created', :item => @user.class.human_name)
      redirect_to admin_user_path(@user)
    else
      flash.now[:error] = t('item.not_created', :item => @user.class.human_name)
      render :new
    end
  end

  def edit
    #end
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:notice] = t('user.updated')
      redirect_to admin_user_url(@user)
    else
      flash.now[:error] = t('user.not_updated')
      render :action => "edit"
    end
  end

  def destroy
    if @user.destroy
      flash[:notice] = t('user.deleted')
      redirect_to admin_users_url
    else
      flash[:error] = t('user.not_deleted') + ": " + @user.errors.full_messages.to_sentence
      redirect_to admin_user_url(@user)
    end
  end

  def suspend
    if @user.suspend!
      flash[:notice] = t('user.suspended')
    else
      flash[:error] = t('user.not_suspended')
    end
    redirect_to admin_user_url(@user)
  end

  def unsuspend
    if @user.unsuspend!
      flash[:notice] = t('user.unsuspended')
    else
      flash[:error] = t('user.not_unsuspended')
    end
    redirect_to admin_user_url(@user)
  end

  private

  def find_user
    @user = User.find_by_id params[:id]
    unless @user
      flash[:error] = t('user.not_found')
      redirect_to admin_users_url
      return
    end
  end

end
