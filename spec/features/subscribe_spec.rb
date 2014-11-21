require 'rails_helper'


feature 'Subscribe' do

	scenario 'successfull join to landing page' do
		visit root_path

		within("#subscribe") do
			fill_in("email", with: "test@test.com")
			click_button "SUBSCRIBE"
		end

		expect(page).to have_content("Successfully added to our mailing list.")
	end

	scenario 'wrong email format' do
		visit root_path
		within("#subscribe") do
			fill_in("email", with: "test_test.com")
			click_button "SUBSCRIBE"
		end

		expect(page).to have_content("incorrect email format")
	end

end