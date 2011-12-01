class CreatePapers < ActiveRecord::Migration
  def self.up
    create_table :papers do |t|
      t.string :title
      t.string :author
      
      t.integer :year   # 年
      t.string :journal # 期刊
      t.integer :volume  # 卷
      t.integer :issue   # 期
      t.integer :page_start
      t.integer :page_end
      
      t.text :summary
      t.string :keywords
      t.string :link
      t.string :doi
      
      t.integer :user_id

      t.timestamps
    end
  end
  
  def self.down
    drop_table :papers
  end
    
end
