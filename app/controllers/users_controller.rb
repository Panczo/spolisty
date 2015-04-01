class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all.order("created_at DESC")
  end

  def show
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end
    @tracks = @user.tracks.classified
    @chart = @user.charts.build
  end

  def following
    @user = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end
  
end
