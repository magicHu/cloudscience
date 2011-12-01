class Folder < ActiveRecord::Base
  belongs_to :user
  
  has_many :folder_papers, :dependent => :destroy
  has_many :papers, :through => :folder_papers
  
  validates :name, :presence => true, :uniqueness => {:scope => :user_id, :case_sensitive => false}
  
end
