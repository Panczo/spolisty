require 'rails_helper'

feature 'Landing page' do
	scenario 'have name of application' do
		visit root_path
		within(".lead") do
			expect(page).to have_content("Explore your music with friends")
		end
	end
end