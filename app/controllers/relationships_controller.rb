class RelationshipsController < ApplicationController
  before_action :authenticate_user! 

  def create
    user = User.find(params[:followed_id])
    current_user.follow(user)
    flash[:success] = I18n.t('main_site.relationship.follow', user: user.nick) 
    redirect_to user
  end

  def destroy
    user = Relationship.find(params[:id]).followed
    current_user.unfollow(user)
    flash[:success] = I18n.t('main_site.relationship.unfollow', user: user.nick) 
    redirect_to user 
  end
end
