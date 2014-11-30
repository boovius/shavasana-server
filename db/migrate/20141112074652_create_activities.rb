class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string  :title
      t.integer :weekly
      t.integer :monthly
      t.timestamps
    end
  end
end
