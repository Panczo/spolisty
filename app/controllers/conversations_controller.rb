class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_mailbox
  before_action :find_user
  before_action :get_conversation, except: [:index, :empty_trash]
  before_action :get_box, only: [:index]

  def index
    if @box.eql? "inbox"
      @conversations = @mailbox.inbox
    elsif @box.eql? "sent"
      @conversations = @mailbox.sentbox
    else
      @conversations = @mailbox.trash
    end

    @conversations = @conversations.paginate(page: params[:page], per_page: 10)
  end

  def show
  end

  def reply
    current_user.reply_to_conversation(@conversation, params[:body])
    flash[:success] = 'Reply sent'
    redirect_to user_conversation_path(current_user, :id => @conversation)
  end

  def destroy
    @conversation.move_to_trash(current_user)
    flash[:success] = 'The conversation was moved to trash.'
    redirect_to :back
  end
 
  def restore
    @conversation.untrash(current_user)
    flash[:success] = 'The conversation was restored.'
    redirect_to user_conversation_path(current_user, :id => @conversation)
  end


  def empty_trash
    @mailbox.trash.each do |conversation|
      conversation.receipts_for(current_user).update_all(deleted: true)
    end
    flash[:success] = 'Your trash was cleaned!'
    redirect_to user_conversations_path(current_user)
  end

  private

  def get_box
    if params[:box].blank? or !["inbox", "sent", "trash"]
      params[:box] = "inbox"
    end
    @box = params[:box]
  end

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
