require 'rails_helper' 

feature 'upload tracks' do 
  
  scenario 'upload tracks to spotify playlist' do

    visit pages_path
    expect(page).to have_content("CONNECT WITH SPOTIFY")
    VCR::use_cassette('Sign:in:to:spotify') do
      click_link "CONNECT WITH SPOTIFY", match: :first
    end

    visit users_path
    click_link "testsanczo"
    click_link "spolisty"
    expect(page).to have_link("Send your playlist to Spotify")
    
    VCR::use_cassette('Export:playlist:with:tracks:to:spotify') do
      click_link "Send your playlist to Spotify"
    end

    expect(page).to have_content("Successfully exported playlist to Spotify")
  end
end