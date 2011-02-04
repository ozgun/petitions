class PagesController < ApplicationController

  # Path'i "/sayfa-adı" ve "/kategori/sayfa-adı" şeklindeki
  # olan sayfaları bulur. 
  def show
    if ignored_paths.include?(params[:path][0]) 
      render :text => "URL dosya bulunumadi!"
      return false
    end
    #if @page
    # logger.debug "-----------xxxxx: #{@page.inspect}---------"
    #else
    # logger.debug "-----------xxxxx: ---------"
    #end
    path_arr = params[:path]
    if path_arr.size > 1 #kategori içindeki bir sayfaya erişilmeye çalışılıyor
      @category = PageCategory.find(Sanitize.clean(path_arr[0]))
      page_slug = Sanitize.clean(path_arr[1])
    else
      page_slug = Sanitize.clean(path_arr[0])
      @category = nil
    end
    if @category
      if preview?
        @page = @category.pages.find(page_slug)
      else
        @page = @category.pages.active.find(page_slug)
      end
    else
      if preview?
        @page = Page.find(page_slug)
      else
        @page = Page.active.find(page_slug)
      end
    end
    unless @page
      flash.now[:error] = t('requested_page_not_found')
      #redirect_to root_path
    end
  rescue Exception => e
    logger.error "************************************************************"
    logger.error "[ERROR!] PagesController: #{e.message}"
    logger.error "[ERROR!] path #{params[:path].inspect}"
    logger.error "************************************************************"
    #e.log
    flash.now[:error] = t('requested_page_not_found')
    #redirect_to root_path
  end

  def ignored_paths
    ["data", "favicon.ico", "images", "stylesheets", "javascripts"]
  end

  def preview?
    params[:preview] and admin?
  end

end
