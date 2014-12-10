class ChangeTypeColumnInPlaylists < ActiveRecord::Migration
  def change
  	rename_column :playlists, :type, :spotify_type
  end
end
