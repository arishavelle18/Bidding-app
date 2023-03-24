class Admin < ApplicationRecord
    has_many :products
    has_secure_password
end
