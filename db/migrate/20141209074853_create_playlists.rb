class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.string :name
      t.text :description
      t.integer :followers_count
      t.string :id_spotify
      t.string :type

      t.timestamps null: false
    end
  end
end
