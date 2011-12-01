class Idea < ActiveRecord::Base
  default_scope :order => 'created_at desc'
  
  belongs_to :user
  
  validates :title, :desc, :presence => true
  
  # 0: 提交；1：正在处理；2：处理完毕；
  def wait_for_deal?
    state == 0
  end
  
  def open
    self.state = 1
  end
  
  def deal_with?
    state == 1
  end
  
  def close
    self.state = 2
    self.deal_time = Time.now
  end
  
  def finish?
    state == 2
  end
end
