class Admin::AssetsController < ApplicationController
  before_filter :require_admin

  def index
    unless params[:search]
      params[:search] = {:order => "descend_by_created_at"}
    end
    @search = Asset.search(params[:search])
    @assets, @asset_count = @search.paginate(:page => params[:page], :per_page => 20), @search.count
  end

  def new
    @asset = Asset.new
  end

  def create
    @asset = Asset.new(params[:asset])
    if @asset.valid? and !params[:asset][:metadata].blank? and @asset.save
      flash[:notice] = t('asset.uploaded')
      redirect_to admin_assets_url
    else
      flash.now[:error] = t('asset.not_uploaded')
      render :new
    end
  end

  #def show
  #  @asset = Asset.find_by_id params[:id]
  #  if @asset and File.exists?(@asset.metadata.path)
  #    send_file @asset.metadata.path
  #  else
  #    flash[:error] = "File not found!"
  #    redirect_to admin_assets_url
  #  end
  #end

  def edit
    @asset = Asset.find_by_id params[:id]
  end

  def update
    @asset = Asset.find_by_id params[:id]
    if @asset and @asset.update_attributes(params[:asset])
      flash[:notice] = "Asset updated."
      redirect_to admin_assets_path
    else
      flash[:error] = "Error! Asset not updated!"
      render :edit
    end
  end

  def destroy
    @item_deleted = false
    @asset = Asset.find_by_id params[:id]
    if @asset and @asset.destroy
      @asset_count = Asset.count
      @item_deleted = true
      flash.now[:notice] = t('asset.deleted')
    else
      flash.now[:error] = t('asset.not_deleted')
    end
    respond_to do |format|
      format.html {
        redirect_to admin_assets_path
      }
      format.js {}
    end
  end

end
