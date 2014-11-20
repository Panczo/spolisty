class SubscribersController < ApplicationController

	def create


		@list_id = ENV['MAILCHIMP_LIST']
    gb = Gibbon::API.new

    result = gb.lists.subscribe({
      :id => @list_id,
      :email => {:email => params[:email][:address]}
      })


		begin
  		Gibbon::API.new(ENV['MAILCHIMP']).lists.subscribe({:id => ENV['MAILCHIMP_LIST'], :email => {:email => params[:email][:address]}, :double_optin => false})
  		 flash[:success] = "Twój komentarz został dodany"   
		rescue Gibbon::MailChimpError => e
		  return redirect_to root_path, :flash => { error: e.message }
		end

		gb = Gibbon::API.new

	  result = gb.lists.subscribe({:id => “campaign_list_id”, :email => email}, :double_optin => false})

	  Rails.logger.error(“Error from MailChimp: #{result[‘error’]}”) if result[“status”] == “error”
	end
end
