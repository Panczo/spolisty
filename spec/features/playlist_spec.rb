require 'rails_helper'

feature 'user', :omniauth do 
	before(:each) do

		@user = VCR.use_cassette('user_spotify_hash') do
				RSpotify::User.find('testsanczo')
			end
		signin
	end

	scenario 'after first sign in see import playlist button' do
		expect(page).to have_content("Import your playlists from spotify")
	end

	scenario 'visit playlist show page' do
		click_link "show playlist"

		expect(page).to have_content("Playlist")
	end

end