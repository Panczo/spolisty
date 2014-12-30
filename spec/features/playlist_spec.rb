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


	scenario 'can import all his playlists' do
		VCR.use_cassette('import_playlist') do
			click_link "Import your playlists from spotify", match: :first
			expect(page).to have_content("Successfully imported playlists")
		end
	end
end