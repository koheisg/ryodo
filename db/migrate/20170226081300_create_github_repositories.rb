class CreateGithubRepositories < ActiveRecord::Migration[5.0]
  def change
    create_table :github_repositories do |t|
      t.string :name
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
