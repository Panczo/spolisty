require 'rails_helper'


feature 'Spotify Auth' do
	scenario 'signing with Spotify account' do
		visit root_path
		mock_auth_hash
		click_link "CONNECT WITH SPOTIFY", match: :first

		expect(page).to have_content("Successfully login with spotify")
		expect(page).to have_content("Signed is as a Claudio Poli")
	end

end