module PapersHelper
  
  include ActsAsTaggableOn::TagsHelper
  
  def is_in_library(paper)
    current_user.favorite_papers.include?(paper)
  end
  
  def is_my_publish?(paper)
    paper.user_id == current_user.id
  end
end
