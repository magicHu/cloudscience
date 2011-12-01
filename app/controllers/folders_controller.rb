class FoldersController < ApplicationController
  layout 'library'

  before_filter :find_folder, :only => [:edit, :update, :destroy, :add_paper, :remove_paper]
  
  def add_paper
    @paper = Paper.find(params[:paper_id])
    @folder_paper = @folder.folder_papers.build(:paper => @paper)

    respond_to do |format|
      if @folder_paper.save
        format.html { head :ok }
      end
    end
  end
  
  def remove_paper
    @paper = Paper.find(params[:paper_id])
    @folder_paper = @folder.folder_papers.where(:paper_id => @paper.id).first

    logger.debug(@folder_paper.inspect)
    respond_to do |format|
      if @folder_paper.destroy
        format.html { head :ok }
      end
    end
  end
  
  def refresh
    @folders = current_user.folders.all
    
    respond_to do |format|
      format.html { render :partial => '/layouts/folder', :layout => false }
      format.json { render :json => @folders }
    end
  end

  # GET /folders
  # GET /folders.json
  def index
    @folders = current_user.folders.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @folders }
    end
  end

  # GET /folders/1
  # GET /folders/1.json
  def show
    @folder = current_user.folders.find_by_name(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @folder }
    end
  end

  # GET /folders/new
  # GET /folders/new.json
  def new
    @folder = current_user.folders.build

    respond_to do |format|
      format.html { render :layout => false }
      format.json { render :json => @folder }
    end
  end

  # GET /folders/1/edit
  def edit

    respond_to do |format|
      format.html { render :layout => false }
    end
  end

  # POST /folders
  # POST /folders.json
  def create
    @folder = current_user.folders.build(params[:folder])

    respond_to do |format|
      if @folder.save
        format.html { redirect_to library_url, :notice => 'Folder was successfully created.' }
        format.json { render :json => @folder, :status => :created, :location => @folder }
      else
        format.html { render :action => "new" }
        format.json { render :json => @folder.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /folders/1
  # PUT /folders/1.json
  def update
    respond_to do |format|
      if @folder.update_attributes(params[:folder])
        format.html { redirect_to folder_url(:id => @folder.name), :notice => 'Folder was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @folder.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /folders/1
  # DELETE /folders/1.json
  def destroy
    @folder.destroy

    respond_to do |format|
      format.html { redirect_to library_url, :notice => 'Folder was successfully removed.' }
      format.json { head :ok }
    end
  end

  private

  def find_folder()
    @folder = current_user.folders.find(params[:id])
  end

end
