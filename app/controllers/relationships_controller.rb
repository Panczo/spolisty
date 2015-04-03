class RelationshipsController < ApplicationController
  before_action :authenticate_user! 

  def create
    user = User.find(params[:followed_id])
    current_user.follow(user)
    flash[:success] = "Now you follow #{user.nick}" 
    redirect_to user
  end

  def destroy
    user = Relationship.find(params[:id]).followed
    current_user.unfollow(user)
    flash[:success] = "Now you unfollow #{user.nick}" 
    redirect_to user 
  end
end
