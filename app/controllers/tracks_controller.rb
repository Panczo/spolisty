class TracksController < ApplicationController
  before_action :authenticate_user!

  def addtrack
    user = User.find(params[:user_id])
    track = Track.find(params[:id]).dup
    
    if current_user == user 
      @playlist = Playlist.find_or_initialize_by(name: 'spolisty', user: user) do |playlist|
        playlist.user = current_user
        playlist.spotify_type = "playlist"
      end

      unless @playlist.tracks.include? track
        @playlist.tracks << track
      end
      
      if @playlist.save
        flash[:success] = "Successfully added track - #{track.name} to playlist - #{@playlist.name}"
        redirect_to :back
      else
        flash[:error] = 'error'
        redirect_to :back
      end
    end
  end
end
