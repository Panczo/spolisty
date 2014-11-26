require 'rails_helper'


feature 'Spotify Auth', :omniauth do

	scenario 'signing with Spotify account' do
		signin

		expect(page).to have_content("Successfully authenticated from Spotify account.")
	end

end