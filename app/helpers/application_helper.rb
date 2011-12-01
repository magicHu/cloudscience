module ApplicationHelper
  def tag_taggings
    current_user.owned_taggings.group_by(&:tag)
  end
end
