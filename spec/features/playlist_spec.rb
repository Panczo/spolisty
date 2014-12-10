require 'rails_helper'

	feature 'user playlist' do 

		scenario 'user after first sign in see import playlist button' do
			user = create(:user)
			signin

			expect(page).to have_content("Import your playlists from spotify")

		end
	end