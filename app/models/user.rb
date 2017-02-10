class User < ApplicationRecord
  has_many :microposts, dependent: :destroy
  has_secure_password
end
