class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.timestamps
      t.index :email, unique: true
    end
  end
end
