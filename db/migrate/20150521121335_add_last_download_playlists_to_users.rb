class AddLastDownloadPlaylistsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_download_playlists, :datetime
  end
end
