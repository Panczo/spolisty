require 'rails_helper'

feature 'user', :omniauth do 
	before(:each) do
		signin
	end

	scenario 'after first sign in see import playlist button' do
		expect(page).to have_content("Import your playlists from spotify")
	end

	scenario 'visit playlist show page' do
		@userrr = VCR.use_cassette('spotify_user') do
			RSpotify::User.new(auth_mock)
		end
		
		click_link "Import your playlists from spotify", match: :first

		@playlist = VCR.use_cassette('imports_playlists') do
			@userrr.playlists
		end

		expect(page).to have_content("Playlist")
		expect(page).to_not have_link("Import your playlists from spotify")
	end

end