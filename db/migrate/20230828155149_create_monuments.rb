class CreateMonuments < ActiveRecord::Migration[7.0]
  def change
    create_table :monuments do |t|
      t.string :title
      t.string :short_description
      t.text :long_description
      t.integer :points
      t.string :address

      t.timestamps
    end
  end
end
