class AssetsController < ApplicationController

  def show
    @sample = Sample.find_by_id(params[:sid])
    @asset = @sample.assets.find_by_id(params[:id])
    if @sample and @asset
      send_file @asset.metadata.path
    else
      flash[:error] = t('asset.not_found')
      redirect_to root_path
    end
  end

end
