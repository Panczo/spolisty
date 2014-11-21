class PagesController < ApplicationController
	layout "landing"

  def index
  	@subscribe = Subscribe.new
  end
  
end
