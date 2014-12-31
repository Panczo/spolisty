class PlaylistsController < ApplicationController
	before_action :authenticate_user!
  before_action :find_user, only: [:show, :destroy]
  before_action :find_playlist, only: [:show, :destroy]
  respond_to :html

	def index
    redirect_to current_user
	end

  def show
  end

  def destroy 
    @playlist.destroy
    redirect_to @user
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
