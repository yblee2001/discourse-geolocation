
class AddUserIdToGeoNotes < ActiveRecord::Migration[6.1]
    def change
      add_reference :geo_notes, :user, foreign_key: true
    end
  end

