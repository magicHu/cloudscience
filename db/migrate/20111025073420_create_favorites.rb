class CreateFavorites < ActiveRecord::Migration
  def self.up
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :paper_id

      t.timestamps
    end
    
    add_index :favorites, :user_id
    add_index :favorites, :paper_id
  end
  
  def self.down
    drop_tables :favorites
  end
end
