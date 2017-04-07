class CreateArticleTags < ActiveRecord::Migration[5.0]
  def change
    create_table :article_tags do |t|
      t.references :article, foreign_key: true
      t.references :tag, foreign_key: true
      t.timestamps
      t.index [:article_id, :tag_id], unique: true
    end
  end
end
