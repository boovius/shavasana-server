class CreateDoings < ActiveRecord::Migration
  def change
    create_table :doings do |t|
      t.string   :name
      t.integer  :activity_id
      t.timestamps
    end
  end
end
