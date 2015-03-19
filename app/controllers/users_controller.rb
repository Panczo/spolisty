class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all.order("created_at DESC")
  end

  def show
    @user = User.find(params[:id])
    @tracks = @user.tracks.classified
    @chart = @user.charts.build
  end
  
end
