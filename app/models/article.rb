class Article < ApplicationRecord
  belongs_to :user
  has_many :article_tags
  has_many :tags, through: :article_tags
  accepts_nested_attributes_for :article_tags, reject_if: :all_blank
  validates :title, presence: true, length: { maximum: 50 }
end
