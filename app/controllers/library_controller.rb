class LibraryController < ApplicationController
  layout 'library'
  
  def index
    @papers = current_user.favorite_papers.page(params[:page])
    
    respond_to do |format|
      format.html
    end
  end
  
  def publications
    @papers = current_user.publish_papers.page(params[:page])
    
    render :index
  end
  
  def search
    keyword = params[:keyword] || ''
    @papers = current_user.favorite_papers.page(params[:page]).search(keyword)
    
    render :index
  end
  
  def paper
    @paper = current_user.favorite_papers.find(params[:id])
    @tags = @paper.tags_from(current_user).to_s
    
    respond_to do |format|
      format.html
    end
  end
  
  def update_paper
    @paper = current_user.favorite_papers.find(params[:id])
    current_user.tag(@paper, :with => params[:tags], :on => :tags)
    
    redirect_to :action => :paper
  end

end
