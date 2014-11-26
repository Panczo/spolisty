class AddSpotifyHashToUsers < ActiveRecord::Migration
  def change
    add_column :users, :spotify_hash, :string
  end
end
