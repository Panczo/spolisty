class AddImageToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :image, :text
  end
end
