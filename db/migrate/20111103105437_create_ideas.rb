class CreateIdeas < ActiveRecord::Migration
  def self.up
    create_table :ideas do |t|
      t.string :title
      t.text :desc
      # 0: 提交；1：正在处理；2：处理完毕；
      t.integer :state, :default => 0
      t.time :deal_time
      t.string :deal_user
      t.text :note

      t.timestamps
      
      t.integer :user_id
    end
  end
  
  def self.down
    drop_table :ideas
  end
end
