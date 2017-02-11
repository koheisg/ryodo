class User < ApplicationRecord
  has_many :articles
  has_secure_password
end
