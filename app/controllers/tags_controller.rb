class TagsController < ApplicationController
  layout 'library'
  before_filter :find_tag, :only => [:show, :edit, :update, :destroy]
  
  # GET /tags
  # GET /tags.json
  def index
    @tags = current_user.owned_tags

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @tags }
    end
  end
  
  # GET /tags/1
  # GET /tags/1.json
  def show
    @taggings = current_user.owned_taggings(:include => :taggable).where("#{ActsAsTaggableOn::Tagging.table_name}.tag_id = ?", @tag.id)
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @tag }
    end
  end

  # GET /tags/new
  # GET /tags/new.json
  def new
    @tag = current_user.tags.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @tag }
    end
  end

  # GET /tags/1/edit
  def edit
  end

  # POST /tags
  # POST /tags.json
  def create
    @tagnames = params[:tagnames] || ''
    if @tagnames.blank?
      redirect_to tags_url
    end
    
    @tagnames.split(';').each do |tagname|
      current_user.tags.create(:name => tagname.chomp)
    end

    respond_to do |format|
      format.html { redirect_to tags_url, :notice => 'Tag was successfully created.' }
    end
  end

  # PUT /tags/1
  # PUT /tags/1.json
  def update
    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        format.html { redirect_to @tag, :notice => 'Tag was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @tag.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.json
  def destroy
    @tag.destroy

    respond_to do |format|
      format.html { redirect_to tags_url }
      format.json { head :ok }
    end
  end
  
  private
  def find_tag
    @tag = ActsAsTaggableOn::Tag.find_by_name(params[:id])
  end

end
