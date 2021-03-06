# == Schema Information
#
# Table name: subscribes
#
#  id         :integer          not null, primary key
#  email      :string
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe Subscribe, :type => :model do
	
	it 'its valid with email present' do
		sub = Subscribe.new(
				email: "test@test.com"
			)

		expect(sub).to be_valid
	end

	it 'its invalid without email' do
		sub = Subscribe.new(email: '')

		expect(sub).to_not be_valid
	end

	it 'incorrect emails' do

		addresses = %w[test@test,com test_test.com test.test@test. test@te+st.com]
		addresses.each do |wrong_email|
			@email = Subscribe.new(email: wrong_email)
		end

		expect(@email).to_not be_valid
	end

end
