# frozen_string_literal: true
class AddLatitudeToGeoNotes < ActiveRecord::Migration[7.1]
  def change
    add_column :geo_notes, :latitude, :string
  end
end
