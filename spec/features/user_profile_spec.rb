require 'rails_helper'

feature 'User profile page' do

	scenario 'after success login user see own info', :omniauth do
		signin

		expect(page).to have_content("Successfully authenticated from Spotify account.")
		expect(current_path).to eq('/users/1')
		expect(page).to have_content("Mario Poli")


		click_link "logout"

		expect(current_path).to eq('/')
	end

	scenario 'user see profile other user' do
		signin
		user2 = create(:user)

	end

end