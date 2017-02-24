class Article < ApplicationRecord
  belongs_to :user
  has_many :tags, through: :article_tags

  def to_param
    permalink
  end

  private

    def permalink
      "#{title}"
    end
end
