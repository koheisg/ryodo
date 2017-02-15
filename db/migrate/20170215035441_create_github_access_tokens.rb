class CreateGithubAccessTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :github_access_tokens do |t|
      t.string :access_token
      t.string :scope
      t.string :token_type
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
