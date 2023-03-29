class AdminUser < ApplicationRecord
  after_create :create_user_record
  private

  def create_user_record
    user = User.new(full_name:full_name,email: email, password:password,password_confirmation:password,is_admin:true)

    if user.valid?
      user.save
    else
      # ipapakita ang validation errors ng user model
      errors.add(:base, user.errors.full_messages.join(', '))
      raise ActiveRecord::Rollback
    end
  end 
  
  validates :full_name,presence:true,length:{maximum:50},format: { with: /\A[a-zA-Z\s]+\z/, message: "only allows letters and spaces" }
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable
end
