class PapersController < ApplicationController
  # GET /papers
  # GET /papers.json
  def index
    @papers = Paper.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @papers }
    end
  end

  def search
    keyword = params[:keyword] || ''
    @papers = Paper.search(keyword).page(params[:page])
    
    render :index
  end
  
  def add_to_library
    @paper = Paper.find(params[:id])
    current_user.favorite_papers << @paper
    current_user.save
    
    respond_to do |format|
      format.html { redirect_to @paper }
    end
  end
  
  def remove_from_library
    @paper = Paper.find(params[:id])
    current_user.favorite_papers.delete(@paper)
    current_user.save
    
    respond_to do |format|
      format.html { redirect_to library_url }
    end
  end
  
  def add_to_folder
    @paper = Paper.find(params[:id])
    @folder = current_user.folders.find(params[:folder_id])
    
    @paper.folders << @folder
    respond_to do |format|
      if @paper.save
        format.html { head :ok }
      end
    end
  end
  
  def remove_from_folder
    @paper = Paper.find(params[:id])
    @folder = current_user.folders.find(params[:folder_id])
    
    @paper.folders.delete(@folder)
    respond_to do |format|
      if @paper.save
        format.html { head :ok }
      end
    end
  end
  
  def publish
    @paper = Paper.find(params[:id])
    current_user.publish_papers << @paper
    current_user.save
    
    respond_to do |format|
      format.html { redirect_to @paper }
    end
  end

  # GET /papers/1
  # GET /papers/1.json
  def show
    @paper = Paper.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @paper }
      format.xml { render :xml => @paper }
    end
  end

  # GET /papers/new
  # GET /papers/new.json
  def new
    @paper = Paper.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @paper }
    end
  end

  # GET /papers/1/edit
  def edit
    @paper = Paper.find(params[:id])
  end

  # POST /papers
  # POST /papers.json
  def create
    @paper = current_user.upload_papers.build(params[:paper])
    
    respond_to do |format|
      begin
        Paper.transaction do
          if @paper.is_publisher?
            current_user.publish_papers << @paper
          end
          
          @paper.save
          current_user.favorite_papers << @paper
          current_user.save
        end
        
        format.html { redirect_to @paper, :notice => "Paper was successfully created." }
        format.json { render :json => @paper, :status => :created, :location => @paper }
      rescue Exception => ex
        @exception = ex
        format.html { render :action => "new", :notice => ex }
        format.json { render :json => @paper.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /papers/1
  # PUT /papers/1.json
  def update
    @paper = Paper.find(params[:id])

    respond_to do |format|
      if @paper.update_attributes(params[:paper])
        format.html { redirect_to @paper, :notice => 'Paper was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @paper.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /papers/1
  # DELETE /papers/1.json
  def destroy
    @paper = Paper.find(params[:id])
    @paper.destroy

    respond_to do |format|
      format.html { redirect_to papers_url }
      format.json { head :ok }
    end
  end
end
