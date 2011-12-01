class FolderPaper < ActiveRecord::Base
  belongs_to :folder, :counter_cache => true
  belongs_to :paper
end
