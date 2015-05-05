class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_mailbox
  before_action :find_user, only: [:index]
  before_action :get_conversation, except: [:index]

  def index
    @conversations = @mailbox.inbox.paginate(page: params[:page], per_page: 10)
  end

  private

  def get_mailbox
    @mailbox ||= current_user.mailbox
  end

  def find_user
    @user = User.find(params[:user_id])
  end
end
