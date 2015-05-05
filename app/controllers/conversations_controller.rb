class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_mailbox
  before_action :find_user
  before_action :get_conversation, except: [:index]

  def index
    @conversations = @mailbox.inbox.paginate(page: params[:page], per_page: 10)
  end

  def show
  end

  def reply
    current_user.reply_to_conversation(@conversation, params[:body])
    flash[:success] = 'Reply sent'
    redirect_to user_conversation_path(current_user, :id => @conversation)
  end

  private

  def get_mailbox
    @mailbox ||= current_user.mailbox
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def get_conversation
    @conversation ||= @mailbox.conversations.find(params[:id])
  end
end
