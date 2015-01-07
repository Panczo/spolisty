class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name

      t.timestamps null: false
    end
    add_column :tracks, :artist_id, :integer
    add_index :tracks, :artist_id
  end
end
