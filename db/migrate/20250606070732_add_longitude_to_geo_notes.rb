# frozen_string_literal: true
class AddLongitudeToGeoNotes < ActiveRecord::Migration[7.1]
  def change
    add_column :geo_notes, :longitude, :string
  end
end
