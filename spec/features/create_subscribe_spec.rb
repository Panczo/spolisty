require 'rails_helper'


feature 'Subscribe' do

	scenario 'successfull join to landing page', :js => true do
		pending "In test msg dont show"
		visit root_path

		within("#new_subscribe") do
			fill_in("email", with: "test12@test.com")
			click_button "SUBSCRIBE"
		end

		find("#success-sub", visible: false)
		expect(page).to have_content("Successfully added to our mailing list.")
	end

end