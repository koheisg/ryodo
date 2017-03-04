class GithubRepository < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, length: { maximum: 24 }, format: { with: /\A[a-zA-Z0-9]+\z/ }
end
