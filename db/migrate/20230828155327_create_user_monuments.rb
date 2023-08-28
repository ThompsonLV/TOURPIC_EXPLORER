class CreateUserMonuments < ActiveRecord::Migration[7.0]
  def change
    create_table :user_monuments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :monument, null: false, foreign_key: true
      t.boolean :favoris

      t.timestamps
    end
  end
end
