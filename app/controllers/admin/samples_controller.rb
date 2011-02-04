class Admin::SamplesController < ApplicationController
  before_filter :require_admin
  before_filter :find_document

  # GET /samples/new
  # GET /samples/new.xml
  def new
    @sample = Sample.new
    @sample.document_id = @document.id
    @sample.position = @document.samples.size + 1
    2.times { @sample.assets.build }

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sample }
    end
  end

  # POST /samples
  # POST /samples.xml
  def create
    @sample = Sample.new(params[:sample])
    @sample.document_id = @document.id

    respond_to do |format|
      if @sample.save
        flash[:notice] = t('item.saved', :item => t('sample.sample'))
        format.html { redirect_to admin_document_path(@document)}
        #format.xml  { render :xml => @sample, :status => :created, :location => @document }
      else
        flash.now[:error] = t('item.created', :item => t('asset.asset'))
        format.html { render :action => "new" }
        #format.xml  { render :xml => @sample.errors, :status => :unprocessable_entity }
      end
    end
  end

  # GET /samples/1/edit
  def edit
    @sample = Sample.find(params[:id])
    2.times{@sample.assets.build}
  end

  # PUT /documents/1
  # PUT /documents/1.xml
  def update
    @sample = Sample.find(params[:id])

    respond_to do |format|
      if @sample.update_attributes(params[:sample])
        flash[:notice] = t('item.updated', :item => t('sample.sample'))
        format.html { redirect_to admin_document_path(@document)}
        format.xml  { head :ok }
      else
        flash.now[:error] = t('item.not_updated', :item => t('sample.sample'))
        format.html { render :action => "edit" }
        format.xml  { render :xml => @document.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /samples/1
  # DELETE /samples/1.xml
  def destroy
    @sample = Sample.find(params[:id])
    if @sample.destroy
      flash[:notice] = t('item.deleted', :item => t('sample.sample'))
    else
      flash[:error] = t('item.not_deleted', :item => t('sample.sample'))
    end

    respond_to do |format|
      format.html { redirect_to(admin_document_path(@document)) }
      format.xml  { head :ok }
    end
  end

  protected

  def find_document
    @document = Document.find(params[:document_id])
  end

end
