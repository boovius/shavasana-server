class AddDoneLastOnToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :done_last_at, :datetime
  end
end
