class PlaylistsController < ApplicationController
	before_action :authenticate_user!
  before_action :find_user, only: [:show]
  before_action :find_playlist, only: [:show]
  respond_to :html

	def index
	end

  def show
  end

  def import
    current_user.import_playlist
    flash[:success] = "Successfully imported playlists"
    redirect_to current_user
  end


  private

  def find_playlist
    @playlist = @user.playlists.find(params[:id])
  end

  def find_user
    @user = User.find(params[:user_id])
  end
end
