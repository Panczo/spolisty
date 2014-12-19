class AddCountOfTracksToPlaylists < ActiveRecord::Migration
  def change
    add_column :playlists, :count_of_tracks, :integer, :default => 0, null: false
  end
end
