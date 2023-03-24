class AddAdminIdToProduct < ActiveRecord::Migration[7.0]
  def self.up
    remove_column :users, :admins_id
  end
end
