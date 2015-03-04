class CreateSpotifyGenres < ActiveRecord::Migration
  def change
    create_table :spotify_genres do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
