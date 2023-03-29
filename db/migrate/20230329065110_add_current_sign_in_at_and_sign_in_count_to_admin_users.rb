class AddCurrentSignInAtAndSignInCountToAdminUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :admin_users, :current_sign_in_at, :datetime
    add_column :admin_users, :sign_in_count, :integer
  end
end
