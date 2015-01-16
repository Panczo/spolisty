class TracksController < ApplicationController
  before_action :authenticate_user!

  def addtrack
    user = User.find(params[:user_id])
    orginal_track = Track.find(params[:id])
    track = orginal_track.dup
    
    if current_user == user 
      @playlist = Playlist.find_or_initialize_by(name: 'spolisty', user: user) do |playlist|
        playlist.user = current_user
        playlist.spotify_type = "playlist"
      end

      unless @playlist.tracks.find_by(track_number: orginal_track.track_number)
        @playlist.tracks << track
        @playlist.save
        flash[:success] = "Successfully added track - #{track.name} to playlist - #{@playlist.name}"
        redirect_to :back
      else
        flash[:error] = "You have this song allready in playlist"
        redirect_to :back
      end
    end
  end
end
