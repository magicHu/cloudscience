class CreatePublishes < ActiveRecord::Migration
  def self.up
    create_table :publishes do |t|
      t.integer :user_id
      t.integer :paper_id

      t.timestamps
    end
    
    add_index :publishes, :user_id
    add_index :publishes, :paper_id
  end
  
  def self.down
    drop_tables :publishes
  end
end
