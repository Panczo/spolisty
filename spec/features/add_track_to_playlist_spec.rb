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
  end

end