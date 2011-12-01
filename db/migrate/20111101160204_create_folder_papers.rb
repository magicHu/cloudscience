class CreateFolderPapers < ActiveRecord::Migration
  def self.up
    create_table :folder_papers do |t|
      t.integer :folder_id
      t.integer :paper_id
      
      t.timestamps
    end
        
    add_index :folder_papers, [:folder_id, :paper_id], :unique => true
    add_index :folder_papers, :folder_id, :unique => false
  end
  
  def self.down
    remove_index :folder_papers, [:folder_id, :paper_id]
    remove_index :folder_papers, :folder_id
    
    drop_table :folder_papers
  end
end
