class SubscribesController < ApplicationController

	def create
		@sub = Subscribe.new(subscribe_params)

		respond_to do |format|
	    if @sub.save
	      format.js
	    else
	      format.js
	    end
  	end
  end

  private

  def subscribe_params
  	params.require(:subscribe).permit(:email)
  end

end
