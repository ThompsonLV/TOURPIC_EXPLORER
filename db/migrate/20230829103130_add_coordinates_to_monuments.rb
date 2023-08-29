class AddCoordinatesToMonuments < ActiveRecord::Migration[7.0]
  def change
    add_column :monuments, :latitude, :float
    add_column :monuments, :longitude, :float
  end
end
