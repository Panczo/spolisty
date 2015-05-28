class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user
 
  def new
  end
 
  def create
    conversation = current_user.send_message(@user, params[:message][:body], params[:message][:subject]).conversation
    flash[:success] = t('main_site.msg.send')
    redirect_to user_conversation_path(current_user, id: conversation)
    #redirect_to user_conversations_path(@user)
  end

  private

  def find_user
    @user ||= User.find(params[:user_id])
  end
end
