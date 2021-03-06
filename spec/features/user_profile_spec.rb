require 'rails_helper'

feature 'User profile page' do

	scenario 'after success login user see own info', :omniauth do
		signin

		expect(page).to have_content("Successfully authenticated from Spotify account.")
		expect(page).to have_content("testsanczo@gmail.com")
	end

	scenario 'after logout user see landing page', :omniauth do
		signin

		click_link "logout"

		expect(current_path).to eq('/')
		expect(page).to_not have_css(".alert")
	end

	scenario 'user see profile other user', :omniauth do
		user2 = create(:user, name: "Mona Lisa")
		signin

		visit user_path(user2)

		within(".user_profile") do
			expect(page).to have_content("Mona Lisa")
		end 

		within('#nav-content') do
			expect(page).to have_css('a#current_user_link')
		end

	end

end