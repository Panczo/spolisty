class AddGenreIdToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :genre_id, :integer
  end
end
