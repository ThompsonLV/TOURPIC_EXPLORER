class CreateMonuments < ActiveRecord::Migration[7.0]
  def change
    create_table :monuments do |t|
      t.string :title
      t.string :short_description
      t.string :long_description
      t.string :picture
      t.integer :points
      t.integer :likes
      t.string :address

      t.timestamps
    end
  end
end
