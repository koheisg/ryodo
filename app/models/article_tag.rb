class ArticleTag < ApplicationRecord
  belongs_to :article, optional: true
  belongs_to :tag
  validates :article_id, :uniqueness => {:scope => :tag_id}
end
