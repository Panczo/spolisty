class ChangeTypeColumnInUsers < ActiveRecord::Migration
  def change
  	change_column :users, :spotify_hash, :text
  	change_column :users, :image, :text
  end
end
