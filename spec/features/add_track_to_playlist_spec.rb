require 'rails_helper'

feature 'add track to playlist', :omniauth do 
  background do
    signin
    userrr = VCR.use_cassette('spotify_user') do
      RSpotify::User.new(auth_mock)
    end
    @user = create(:user, spotify_hash: userrr.to_hash)

    playlists = VCR.use_cassette('user:import:playlists') do
      @user.import_playlist
    end
    expect(@user.playlists.size).to eq(3)

    VCR.use_cassette('user:import:playlists:through') do
      click_link "Import your playlists from spotify", match: :first 
    end
  end
      
  scenario 'visit playlist show page' do
    click_link @user.playlists.first.name
    expect(page.current_path).to eq "/users/1/playlists/4"
  end

  scenario 'delete playlist' do
    click_link 'Focus'
    click_link "Destroy"

    expect(page).to have_content("Playlist deleted")
    expect(page).to_not have_link "Focus"
  end

  scenario 'other user cant delete playlist' do
    other_user = create(:user, name: "Mona Lisa")
    
    4.times do |n|
      Playlist.create(name: "Test#{n}", spotify_type: 'playlist', user: other_user)
    end

    expect(other_user.playlists.size).to eq(4)

    visit user_path(other_user)
    click_link "Test1"
    expect(page).to_not have_link("Destroy")
  end

end