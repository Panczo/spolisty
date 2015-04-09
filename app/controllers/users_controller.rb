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
    if current_user
      @classified_tracks = current_user.tracks.classified.paginate(page: params[:page], per_page: 5)
      @unclassified_tracks = current_user.tracks.unclassified.paginate(page: params[:page], per_page: 5)
    end
    @tracks = @user.tracks.classified
    @chart = @user.charts.build
  end

  def following
    @title = 'following'
    @user = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @title = 'followers'
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end
  
end
