class SubscribersController < ApplicationController

	def create
		begin
			@result = Gibbon::API.new(ENV['MAILCHIMP']).lists.subscribe(
				{
					:id => ENV['MAILCHIMP_LIST'], 
					:email => {:email => params[:email][:address]}, 
					:double_optin => false
				})
				flash[:success] = "#{@result}"
		rescue Gibbon::MailChimpError => e
	  	flash[:error] = "#{e.message}"
		end
	end

end
