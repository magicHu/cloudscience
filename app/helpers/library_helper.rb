module LibraryHelper
  def is_publisher?(paper)
    current_user.publish_papers.include?(paper)
  end
end
