class Tag < ApplicationRecord
  belongs_to :user
  has_many :article_tags
  has_many :articles, through: :article_tags
  validates :name, presence: true, length: { maximum: 20 }
end
