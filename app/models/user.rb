class User < ApplicationRecord
  has_many :articles
  has_many :tags
  has_one :github_access_token
  has_one :github_repository

  def login?
    persisted?
  end
end
