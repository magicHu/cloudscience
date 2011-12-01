class Paper < ActiveRecord::Base

  default_scope order('papers.created_at desc')

  validates :title, :author, :presence => true
  #validates :title, :uniqueness => true

  #validates :year, :volume, :issue, :page_start, :page_end,
  #      :presence => true, :numericality => { :only_integer => true }
        
  attr_accessor :is_publisher

  scope :search, lambda { |keyword| where('title like ?', "%#{keyword}%") }

  belongs_to :owner, :class_name => 'User', :foreign_key => 'user_id'

  acts_as_taggable
  
  has_many :folder_papers, :dependent => :destroy 
  has_many :folders, :through => :folder_papers do
    def by_user(user)
      where('folders.user_id = ?', user.id)
    end
  end
  
  # 收藏
  has_many :favorites, :dependent => :destroy
  # 发布
  has_many :publishes, :dependent => :destroy

  def is_publisher?
    is_publisher == "1"
  end
  
end
