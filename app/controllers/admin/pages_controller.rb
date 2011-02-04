class Admin::PagesController < ApplicationController
  before_filter :require_admin
  before_filter :find_page, :only => [:edit, :update, :destroy, :show]

  def index
    unless params[:search]
      params[:search] = {:order => "ascend_by_title"}
    end
    @search = Page.search(params[:search])
    @pages, @page_count = @search.paginate(:page => params[:page], :per_page => 20), @search.count
  end

  def show
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(params[:page])
    if @page.save
      flash[:notice] = t('page.saved')
      #redirect_to admin_page_path(@page)
      redirect_to admin_pages_path
    else
      flash.now[:error] = t('page.not_saved')
      render :new
    end
  end

  def edit
  end

  def update
    if @page.update_attributes(params[:page])
      flash[:notice] = t('page.updated')
      redirect_to admin_pages_path
    else
      flash.now[:error] = t('page.not_updated')
      render :edit
    end
  end

  def destroy
    @item_deleted = false
    if @page and @page.destroy
      @page_count = Page.count
      @item_deleted = true
    end
    respond_to do |format|
      format.html {
        if @item_deleted
          flash[:notice] = t('page.deleted')
        else
          flash[:error] = t('page.not_deleted')
        end
        redirect_to admin_pages_path
      }
      format.js {
        if @item_deleted
          flash.now[:notice] = t('page.deleted')
        else
          flash.now[:error] = t('page.not_deleted')
        end
      }
    end
  end
  
  private

  def find_page
    @page = Page.find params[:id]
    unless @page
      flash[:error] = t('page.not_found')
      redirect_to admin_pages_path
    end
  end

end
