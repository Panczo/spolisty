class PagesController < ApplicationController
  layout "landing"

  def index
    @subscribe = Subscribe.new
  end

  def faq
  end

  def error_404
    render status: 404
  end
  
end
