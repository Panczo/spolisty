class TracksController < ApplicationController
  before_action :authenticate_user!
  before_action :find_track, only: [:destroy]

  def addtrack
    user = User.find(params[:user_id])
    orginal_track = Track.find(params[:id])
    track = orginal_track.dup
    
    if current_user == user 
      @playlist = Playlist.find_or_initialize_by(name: 'spolisty', user: user) do |playlist|
        playlist.user = current_user
        playlist.spotify_type = "playlist"
        playlist.special = true
      end

      unless @playlist.tracks.find_by(track_number: orginal_track.track_number)
        @playlist.tracks << track
        @playlist.save
        flash[:success] = "Successfully added track - #{track.name} to playlist - #{@playlist.name}"
        redirect_to :back
      else
        flash[:error] = "You have this song already in playlist"
        redirect_to :back
      end
    end
  end

  def destroy
    playlist = @track.playlist
    if current_user == @track.playlist.user
      @track.destroy
      flash[:success] = "Your track was deleted"
      redirect_to [current_user, playlist]
    end
  end

  def edit_multiple
    @tracks = Track.find(params[:track_ids])
  end

  def update_multiple
    user = User.find(params[:user_id])
    @tracks = Track.update(params[:tracks].keys, params[:tracks].values)
    @tracks.reject! { |t| t.errors.empty? }
    if @tracks.empty?
      redirect_to user
    else
      render "edit_multiple"
    end
  end

  private

  def find_track
    @track = current_user.tracks.find(params[:id])
  end

end
