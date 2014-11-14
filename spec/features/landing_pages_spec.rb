require 'rails_helper'

feature 'Landing page' do
	scenario 'have name of application' do
		visit root_path
		within("h1") do
			expect(page).to have_content("SPOLISTY.COM")
		end
	end
end