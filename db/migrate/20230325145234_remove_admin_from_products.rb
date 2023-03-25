class RemoveAdminFromProducts < ActiveRecord::Migration[7.0]
  def change
    remove_reference :products, :admin, null: false, foreign_key: true
  end
end
