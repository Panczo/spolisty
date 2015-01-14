require 'rails_helper'

feature 'add track to playlist', :omniauth do 
  before(:each) do
    signin
  end
      
  scenario 'visit playlist show page' do
    @userrr = VCR.use_cassette('spotify_user') do
      RSpotify::User.new(auth_mock)
    end
    user = create(:user, spotify_hash: @userrr.to_hash)

    @playlists = VCR.use_cassette('user:import:playlists') do
      user.import_playlist
    end
    expect(user.playlists.size).to eq(3)

    VCR.use_cassette('user:import:playlists:through') do
      click_link "Import your playlists from spotify", match: :first 
    end
    click_link user.playlists.first.name
    play = user.playlists.first
    expect(page.current_path).to eq "/users/1/playlists/4"
  end

end