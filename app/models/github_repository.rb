class GithubRepository < ApplicationRecord
  belongs_to :user
<<<<<<< 5b3417374a44d10188cba42db99198fb5dcc5562
=======
  validates :name, presence: true, length: { maximum: 24 }, format: { with: /\A[a-zA-Z0-9]+\z/ }
>>>>>>> Fix validation format for model Github::Repository
end
