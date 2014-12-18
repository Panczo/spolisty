require 'rails_helper'

	feature 'user', :omniauth do 
		before(:each) do
			@user = create(:user)
			signin
		end

		scenario 'after first sign in see import playlist button' do
			expect(page).to have_content("Import your playlists from spotify")
		end


		scenario 'can import all his playlists' do
			click_link "Import your playlists from spotify"

			expect(page).to have_content("Successfully imported playlists")
		end


	end