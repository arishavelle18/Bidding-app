class AddAdminUserToProduct < ActiveRecord::Migration[7.0]
  def change
    add_reference :products, :admin_users, foreign_key: true
  end
end
