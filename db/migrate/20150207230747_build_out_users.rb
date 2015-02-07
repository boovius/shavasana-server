class BuildOutUsers < ActiveRecord::Migration
  def change
    add_column :users, :access_token, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :gender, :string
    add_column :users, :fb_id, :string
    remove_column :users, :name, :string
  end
end
