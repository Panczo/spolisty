require 'rails_helper'

feature 'user', :omniauth do 
	before(:each) do
		signin
	end

	scenario 'after first sign in see import playlist button' do
		expect(page).to have_content("Import your playlists from spotify")
	end

	scenario 'visit playlist show page' do
		Capybara::Screenshot.autosave_on_failure = false
	  client_id     = '5ac1cda2ad354aeaa1ad2693d33bb98c'
    client_secret = '155fc038a85840679b55a1822ef36b9b'
    VCR.use_cassette('authenticate:client') do
      RSpotify.authenticate(client_id, client_secret)
    end

		@userrr = VCR.use_cassette('spotify_user') do
			RSpotify::User.new(auth_mock)
		end
		

		click_link "Import your playlists from spotify", match: :first

		@playlist = VCR.use_cassette('imports_playlists') do
			@userrr.playlists
		end
		screenshot_and_save_page
		expect(page).to have_content("Playlist")
		expect(page).to_not have_link("Import your playlists from spotify")
	end

end