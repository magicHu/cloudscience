class AddCountToPaper < ActiveRecord::Migration
  def change
    add_column :papers, :favorites_count, :integer, :default => 0
    add_column :papers, :publishes_count, :integer, :default => 0
  end
end
