class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :nickname, :name, :research_domain, :workstation, :publish_paper, :education_experience, :mobile, :telephone

  # 校验
  validates :nickname, :presence => true, :uniqueness => true
  validates :name, :research_domain, :presence => true

  # 收藏
  has_many :favorites, :dependent => :destroy
  has_many :favorite_papers, :through => :favorites, :source => :paper
  
  # 发布
  has_many :publishes, :dependent => :destroy
  has_many :publish_papers, :through => :publishes, :source => :paper

  # 上传
  has_many :upload_papers, :class_name => 'Paper', :foreign_key => 'user_id'
  
  # 自定义文件夹
  has_many :folders
  
  # 对系统的意见，内部维护用
  has_many :ideas

  acts_as_tagger
  
end
