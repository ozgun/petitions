class DocumentsController < ApplicationController
  before_filter :set_section
  before_filter :find_category

  # GET /documents
  # GET /documents.xml
  def index
    if @category
      @documents = @category.documents.published.descend_by_created_at.paginate :page => params[:page], :per_page => 15
    elsif @section
      @documents = Document.published.section_identifier_is(@section).descend_by_created_at.paginate :page => params[:page], :per_page => 15
    else
      @documents = Document.published.descend_by_created_at.paginate :page => params[:page], :per_page => 15
    end
    if @documents.empty?
      flash.now[:error] = t('document.documents_not_found')
    end
    #unless params[:search]
    #  params[:search] = {:order => "documents.descend_by_created_at"}
    #  if @category
    #    params[:search][:conditions] = {:category_id => @category}
    #  end
    #end
    #@search = Document.published.search(params[:search])
    #@documents, @document_count = @search.paginate(:page => params[:page], :per_page => 15), @search.count

    respond_to do |format|
      format.html # index.html.erb
      #format.xml  { render :xml => @documents }
    end
  end
  
  def show
    if admin?
      # preview, ön izleme için
      @document = Document.find_by_id(params[:id])
    else
      @document = Document.published.find_by_id(params[:id])
    end
    if @document
      @section = @document.section_identifier
    else
      flash.now[:error] = t('document.not_found')
    end
  end

  protected

  def set_section
    CUSTOM_LOGGER.debug "-----------#{request.request_uri}---------"
    @section = case request.request_uri
    when /^\/dilekceler/
      "dilekceler"
    when /^\/sozlesmeler/
      "sozlesmeler"
    when /^\/diger-yazismalar/
      "diger-yazismalar"
    end
  end

  def find_category
    CUSTOM_LOGGER.debug "-----------#{@section.inspect}---------"
    if @section and params[:category_permalink]
      @category = Category.find :first, :conditions => {:permalink => params[:category_permalink], :section_identifier => @section}
    end
  end

end
