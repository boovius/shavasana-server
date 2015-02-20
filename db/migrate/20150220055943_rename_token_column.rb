class RenameTokenColumn < ActiveRecord::Migration
  def change
    rename_column :users, :access_token, :token
  end
end
