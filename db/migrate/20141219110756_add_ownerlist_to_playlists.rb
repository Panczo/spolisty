class AddOwnerlistToPlaylists < ActiveRecord::Migration
  def change
    add_column :playlists, :ownerlist, :string
  end
end
