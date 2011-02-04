class Admin::DocumentsController < ApplicationController
  before_filter :require_admin

  # GET /documents
  # GET /documents.xml
  def index

    unless params[:search]
      params[:search] = {:order => "documents.descend_by_created_at"}
      if params[:section]
        params[:search][:conditions] = {:section_identifier => params[:section]}
      end
    end
    @search = Document.search(params[:search])
    @documents, @document_count = @search.paginate(:page => params[:page], :per_page => 50), @search.count

    #@documents = Document.desc_by_created_at

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @documents }
    end
  end

  # GET /documents/1
  # GET /documents/1.xml
  def show
    @document = Document.find(params[:id])
    @samples = @document.samples.ascend_by_position

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @document }
    end
  end

  # GET /documents/new
  # GET /documents/new.xml
  def new
    @document = Document.new
    @document.section_identifier = params[:section]
    @categories = Category.find_all_by_section_identifier(params[:section])

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @document }
    end
  end

  # POST /documents
  # POST /documents.xml
  def create
    @document = Document.new(params[:document])

    respond_to do |format|
      if @document.save
        flash[:notice] = t('item.saved', :item => t('document.document'))
        format.html { redirect_to admin_document_path(@document)}
        #format.xml  { render :xml => @document, :status => :created, :location => @document }
      else
        @categories = Category.find_all_by_section_identifier(@document.section_identifier)
        flash.now[:error] = t('item.not_saved', :item => t('document.document'))
        format.html { render :action => "new" }
        #format.xml  { render :xml => @document.errors, :status => :unprocessable_entity }
      end
    end
  end

  # GET /documents/1/edit
  def edit
    @document = Document.find(params[:id])
    @categories = Category.find_all_by_section_identifier(@document.section_identifier)
  end

  # PUT /documents/1
  # PUT /documents/1.xml
  def update
    @document = Document.find(params[:id])

    respond_to do |format|
      if @document.update_attributes(params[:document])
        flash[:notice] = t('item.updated', :item => t('document.document'))
        format.html { redirect_to admin_document_path(@document) }
        format.xml  { head :ok }
      else
        @categories = Category.find_all_by_section_identifier(@document.section_identifier)
        flash.now[:error] = t('item.not_updated', :item => t('document.document'))
        format.html { render :action => "edit" }
        format.xml  { render :xml => @document.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.xml
  def destroy
    @document = Document.find(params[:id])
    if @document.destroy
      flash[:notice] = t('item.deleted', :item => t('document.document'))
    else
      flash[:error] = t('item.not_deleted', :item => t('document.document'))
    end

    respond_to do |format|
      format.html { redirect_to(admin_documents_url, :section => params[:section]) }
      format.xml  { head :ok }
    end
  end
  
end
