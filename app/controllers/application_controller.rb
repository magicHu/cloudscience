class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :authenticate_user!
  
  layout 'application'
  
  rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found
  
  private
  def render_not_found
    render :file => "/public/404", :status => 404
  end
  
end
