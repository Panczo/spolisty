require 'rails_helper'

feature 'Landing page' do
	before(:each) do
		visit root_path
	end

	scenario 'have name of application' do	
		within(".lead") do
			expect(page).to have_content("Explore your music with friends")
		end

		within(".btn-cta", match: :first) do
			expect(page).to have_content("CONNECT WITH SPOTIFY")
		end
	end
end