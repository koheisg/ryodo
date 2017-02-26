class ArticleTag < ApplicationRecord
  belongs_to :article, optional: true
  belongs_to :tag
end
