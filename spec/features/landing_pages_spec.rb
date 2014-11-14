require 'rails_helper'

feature 'Landing page' do
	scenario 'have name of application' do
		visit root_path

		expect(page).to have_content("Spolisty")
	end
end