class User < ApplicationRecord
  has_many :articles
  has_secure_password

  def login?
    persisted?
  end
end
