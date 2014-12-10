# == Schema Information
#
# Table name: subscribes
#
#  id         :integer          not null, primary key
#  email      :string
#  created_at :datetime
#  updated_at :datetime
#

class Subscribe < ActiveRecord::Base
	validates :email, presence: true

	validates :email, :email_format => { :message => 'incorrect email format'}

	after_create :join_to_newsletter


	def join_to_newsletter
		return true if (Rails.env.test?) 

		result = Gibbon::API.new(ENV['MAILCHIMP']).lists.subscribe(
			{
				:id => ENV['MAILCHIMP_LIST'], 
				:email => { :email => self.email }, 
				:double_optin => false
			})
		return result
	end
end
