class User < ApplicationRecord
  has_many :articles
  has_many :tags
  has_one :github_access_token
  has_one :github_repository
<<<<<<< HEAD
=======
  validates :username, presence: true
>>>>>>> Test model User validation
  validates :email, presence: true

  def login?
    persisted?
  end
end
