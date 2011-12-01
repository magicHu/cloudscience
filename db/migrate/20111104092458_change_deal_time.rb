class ChangeDealTime < ActiveRecord::Migration
  def up
    change_column :ideas, :deal_time, :datetime
  end

  def down
    change_column :ideas, :deal_time, :time
  end
end
