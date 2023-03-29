class RemoveColumnsInAdminUser < ActiveRecord::Migration[7.0]
  def self.up
    remove_column :admin_users, :sign_in_count
    remove_column :admin_users, :current_sign_in_at
  end
end

