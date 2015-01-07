class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name

      t.timestamps null: false
    end
    add_column :tracks, :album_id, :integer
    add_index :tracks, :album_id
  end
end
