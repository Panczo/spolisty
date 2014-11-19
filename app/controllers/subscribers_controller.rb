class SubscribersController < ApplicationController

	def create
		@list_id = ENV['MAILCHIMP_LIST']

		gb = Gibbon.new
		gb.lists.subscribe({
			:id => @list_id,
			:email => {:email => params[:email][:address]}
			})
	end
end
