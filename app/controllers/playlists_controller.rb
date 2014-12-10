class PlaylistsController < ApplicationController
	before_action :authenticate_user!
  respond_to :html

	def index
		current_user.import_playlist
		flash[:success] = "Successfully imported playlists"
		redirect_to current_user
	end
end
