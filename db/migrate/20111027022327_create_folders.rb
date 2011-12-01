class CreateFolders < ActiveRecord::Migration
  def self.up
    create_table :folders do |t|
      t.string :name
      t.text :description
      t.integer :user_id
      t.integer :folder_papers_count, :default => 0

      t.timestamps
    end

  end
  
  def self.down
    drop_table :folders
  end
end
