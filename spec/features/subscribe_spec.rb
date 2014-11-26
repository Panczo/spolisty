require 'rails_helper'

feature 'Subscribe' do

	scenario 'successfull join to landing page', :js => true do
		visit root_path

		within("#sub") do
			fill_in("email", with: "test@test.com")
			click_button "SUBSCRIBE"
		end

		expect(page).to have_content("Successfully added to our mailing list.")
	end

	scenario 'wrong email format', :js => true do
		visit root_path
		sub_count = Subscribe.all.count

		within("#sub") do
			fill_in("email", with: "test_test.com")
			click_button "SUBSCRIBE"
		end

		expect(Subscribe.all.count).to eq(sub_count)
	end

end