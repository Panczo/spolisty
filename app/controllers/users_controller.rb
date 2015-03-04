class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all.order("created_at DESC")
  end

  def show
    @user = User.find(params[:id])
<<<<<<< HEAD
=======
    @chart = @user.charts.build
>>>>>>> spotify_genre
  end
  
end
