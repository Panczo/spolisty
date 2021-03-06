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
    @receipts = @conversation.receipts_for(current_user).last(5)
  end

  def reply
    respond_to do |format|
      @receipt = current_user.reply_to_conversation(@conversation, params[:body])
      if @receipt
        format.html do 
          flash[:success] = t('main_site.conversation.send')
          redirect_to user_conversation_path(current_user, :id => @conversation)
        end
        format.js
      else
        format.html {redirect_to user_conversation_path(current_user, :id => @conversation)}
        fotmat.js {render nothing: true}
      end

    end
  end

  def destroy
    @conversation.move_to_trash(current_user)
    flash[:success] = t('main_site.conversation.trash')
    redirect_to :back
  end
 
  def restore
    @conversation.untrash(current_user)
    flash[:success] = t('main_site.conversation.restore')
    redirect_to user_conversation_path(current_user, :id => @conversation)
  end


  def empty_trash
    @mailbox.trash.each do |conversation|
      conversation.receipts_for(current_user).update_all(deleted: true)
    end
    flash[:success] = t('main_site.conversation.empty')
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
