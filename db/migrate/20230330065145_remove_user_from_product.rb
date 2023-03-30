class RemoveUserFromProduct < ActiveRecord::Migration[7.0]
  def change
    remove_reference :products, :user, null: false, foreign_key: true
  end
end
