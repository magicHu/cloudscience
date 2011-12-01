class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :paper, :counter_cache => true
end
