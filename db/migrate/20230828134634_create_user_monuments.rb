class CreateUserMonuments < ActiveRecord::Migration[7.0]
  def change
    create_table :user_monuments do |t|
      t.string :title
      t.string :short_description
      t.string :long_description
      t.string :picture
      t.string :address
      t.references :user, null: false, foreign_key: true
      t.references :monument, null: false, foreign_key: true

      t.timestamps
    end
  end
end
