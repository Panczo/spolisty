class GenresController < ApplicationController
  before_action :authenticate_user! 

  def index
  end
  
  def show
    user = User.find(params[:user]) if params[:user]
    @genre = Genre.find(params[:id])
    @genre_tracks = @genre.tracks.where(user: user) if params[:user]
    @tracks = @genre.tracks.includes({:playlist => :user}, :artist, :album)
  end

end