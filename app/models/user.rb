class User < ApplicationRecord
    has_many :bids
    has_secure_password
end
