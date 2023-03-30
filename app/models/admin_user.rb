class AdminUser < ApplicationRecord
  has_many :products, dependent: :delete_all
  # after_create :create_user_record
  # private

  # def create_user_record
  #   user = User.new(full_name:full_name,email: email, password:password,password_confirmation:password,is_admin:true)

  #   if user.valid?
  #     user.save
  #   else
  #     # ipapakita ang validation errors ng user model
  #     errors.add(:base, user.errors.full_messages.join(', '))
  #     raise ActiveRecord::Rollback
  #   end
  # end 
  
  validates :full_name,presence:true,length:{maximum:50},format: { with: /\A[a-zA-Z\s]+\z/, message: "only allows letters and spaces" }
  before_save :downcase_email

    def downcase_email
        self.email = email.downcase
    end

    # check if the column is presence 
    # check also the length
    # only allow letters and spaces
    # email must be unique
    validates :full_name,presence:true,length:{maximum:50},format: { with: /\A[a-zA-Z\s]+\z/, message: "only allows letters and spaces" }
    # i use valid_email2 gem for advance evaluation of email
    validates :email,presence:true,'valid_email_2/email': true,uniqueness:true
    # my password must contain uppercase,lowercase,digit and special character
    validates :password,presence:true,length:{minimum:8},
    format: { with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]+\z/,
     message: "must contain at least one lowercase letter, one uppercase letter, one digit, and one special character" }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable 
end
