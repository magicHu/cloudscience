class IdeasController < ApplicationController
  
  before_filter :find_idea, :only => [:show, :edit, :update]
  
  def all
    @ideas_group_by_user = Idea.all.group_by(&:user)
  end
  
  # GET /ideas
  # GET /ideas.json
  def index
    @ideas = current_user.ideas.all

    respond_to do |format|
      format.html 
      format.json { render :json => @ideas }
    end
  end
  
  def type
    type = get_state(params[:type])
    
    if type
      @ideas = current_user.ideas.where(:state => type)
    else
      @ideas = current_user.ideas.where()
    end

    respond_to do |format|
      format.html { render 'ideas', :layout => false }
    end
  end
  
  def get_state(type)
    if type == 'all' || type == nil
      nil
    elsif type == 'new'
      0
    elsif type == 'open'
      1
    elsif type == 'close'
      2
    end
  end


  # GET /ideas/1
  # GET /ideas/1.json
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @idea }
    end
  end

  # GET /ideas/new
  # GET /ideas/new.json
  def new
    @idea = current_user.ideas.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @idea }
    end
  end

  # GET /ideas/1/edit
  def edit
  end

  # POST /ideas
  # POST /ideas.json
  def create
    @idea = current_user.ideas.build(params[:idea])

    respond_to do |format|
      if @idea.save
        format.html { redirect_to ideas_url, :notice => 'Idea was successfully created.' }
        format.json { render :json => @idea, :status => :created, :location => @idea }
      else
        format.html { render :action => "new" }
        format.json { render :json => @idea.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ideas/1
  # PUT /ideas/1.json
  def update

    respond_to do |format|
      if @idea.update_attributes(params[:idea])
        format.html { redirect_to ideas_url, :notice => 'Idea was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @idea.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ideas/1
  # DELETE /ideas/1.json
  def destroy
    @idea = Idea.find(params[:id])
    @idea.destroy

    respond_to do |format|
      format.html { redirect_to all_ideas_url }
      format.json { head :ok }
    end
  end
  
  def open
    @idea = Idea.find(params[:id])
    @idea.deal_user = current_user.email
    @idea.open
    @idea.save!
    
    respond_to do |format|
      format.html { redirect_to all_ideas_url }
    end
  end
  
  def close
    @idea = Idea.find(params[:id])
    @idea.close
    @idea.note = params[:note]
    @idea.save!
    
    respond_to do |format|
      format.html { redirect_to all_ideas_url }
    end
  end
  
  private
  def find_idea
    @idea = current_user.ideas.find(params[:id])
  end
    
end
