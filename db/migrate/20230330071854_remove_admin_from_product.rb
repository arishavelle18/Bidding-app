class RemoveAdminFromProduct < ActiveRecord::Migration[7.0]
  def change
    remove_reference :products, :admin_users, null: false, foreign_key: true
    add_reference :products, :admin_user, foreign_key: true
  end
end
