class InsertAdminUser < ActiveRecord::Migration[7.0]
  def change
    AdminUser.create!(full_name:"admintwo",email: 'admin2@example.com', password: 'Password2!', password_confirmation: 'Password2!')
  end
end