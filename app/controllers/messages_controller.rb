class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user
 
  def new
  end
 
  def create
    conversation = current_user.send_message(@user, params[:message][:body], params[:message][:subject]).conversation
    flash[:success] = "Message has been sent!"
    #redirect_to user_conversation_path([current_user, conversation])
    redirect_to user_conversations_path(current_user)
  end

  private

  def find_user
    @user ||= User.find(params[:user_id])
  end
end
