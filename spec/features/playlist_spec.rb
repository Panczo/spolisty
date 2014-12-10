require 'rails_helper'

	feature 'user playlist' do 
		before(:each) do
			user = create(:user)
			signin
		end

		scenario 'user after first sign in see import playlist button' do
			expect(page).to have_content("Import your playlists from spotify")
		end


		scenario 'import all his list' do
			click_link "Import your playlists from spotify"

			within('#nav') do
				expect(page).to have_content("Playlists")
			end

			expect(page).to have_content("Successfully imported playlists")
		end


	end