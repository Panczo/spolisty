class AddSpecialToPlaylists < ActiveRecord::Migration
  def change
    add_column :playlists, :special, :boolean, default: false
  end
end
