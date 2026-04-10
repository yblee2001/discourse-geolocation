class AddCoordinatesToGeoNotes < ActiveRecord::Migration[6.1]
  def change
    add_column :geo_notes, :latitude, :float
    add_column :geo_notes, :longitude, :float
  end
end
