class AddSpotifyIdToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :spotify_id, :string
  end
end
