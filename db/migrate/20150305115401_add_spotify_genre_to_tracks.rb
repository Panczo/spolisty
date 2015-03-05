class AddSpotifyGenreToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :spotify_genre, :string
  end
end
