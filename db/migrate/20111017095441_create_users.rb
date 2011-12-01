class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable

      # t.encryptable
      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable

      t.timestamps
    end
    

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    # add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
    # add_index :users, :authentication_token, :unique => true
    
    # base information
    add_column :users, :nickname, :string
    add_column :users, :name, :string
    add_column :users, :research_domain, :string
    add_column :users, :workstation, :string
    add_column :users, :publish_paper, :text
    add_column :users, :education_experience, :text
    add_column :users, :mobile, :string
    add_column :users, :telephone, :string
    
  end

  def self.down
    drop_table :users
  end
end
