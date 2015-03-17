class GenresController < ApplicationController
  before_action :authenticate_user! 


  def show
    user = User.find(params[:user])
    @genre = Genre.find(params[:id])
    @genre_tracks = @genre.tracks.where(user: user)
  end

end