class PlaylistsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user, only: [:index, :show, :destroy]
  before_action :find_playlist, only: [:show, :destroy]

  respond_to :html

  def index
    @playlists = @user.playlists.includes(:tracks)
    #redirect_to current_user
  end

  def show
    if params[:track]
      @tracks = @playlist.tracks.includes(:artist, :album).where(id: params[:track]).paginate(page: params[:page], per_page: 50)
    else
      @tracks = @playlist.tracks.includes(:artist, :album).paginate(page: params[:page], per_page: 50)
    end
    @rewiews = @playlist.rewiews.includes(:user)

    if @rewiews.blank?
      @average_rating = 0
    else
      @average_rating = @rewiews.average(:rating).round(2)
    end
  end

  def destroy 
    if current_user == @playlist.user
      @playlist.destroy
      flash[:success] = "Playlist deleted"
    else
      flash[:error] = "You can't delete this playlist" 
    end
    redirect_to @user
  end

  def import
    current_user.import_playlist
    flash[:success] = "Successfully imported playlists"
    redirect_to current_user
  end

  def export
    playlist = Playlist.find(params[:id])
    if current_user == playlist.user
      playlist.upload_tracks
    end
    redirect_to :back
    flash[:success] = "Successfully exported playlist to Spotify"
  end


  private

  def find_playlist
    @playlist = @user.playlists.find(params[:id])
  end

  def find_user
    @user = User.find(params[:user_id])
  end
end
