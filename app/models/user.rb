class User < ApplicationRecord
  has_many :articles
  has_many :tags, through: :articles
  has_one :github_access_token
  has_secure_password

  def login?
    persisted?
  end
end
