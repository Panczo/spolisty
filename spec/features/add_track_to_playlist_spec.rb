require 'rails_helper'

feature 'add track to playlist', :omniauth do 
  background do
    signin
    userrr = VCR.use_cassette('spotify_user') do
      RSpotify::User.new(auth_mock)
    end
    @user = create(:user, spotify_hash: userrr.to_hash)
    @playlist = create(:playlist, name: "Trance", user: @user)

    playlists = VCR.use_cassette('user:import:playlists') do
      @user.import_playlist
    end
    expect(@user.playlists.size).to eq(4)

    VCR.use_cassette('user:import:playlists:through') do
      click_link "Import your playlists from spotify", match: :first 
    end
  end
      
  scenario 'visit playlist show page' do
    click_link 'Trance'
    expect(page).to have_content('Trance')
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

  scenario 'add track to own playlist' do
    other_user = create(:user, name: "Mona Lisa")
    @play = create(:playlist, name: "Test", spotify_type: 'playlist', user: other_user)
    4.times do |n|
      @play.tracks.create(name: "track-#{n}", track_number: "#{n}", duration: 10000)
    end

    expect(@play.tracks.size).to eq(4)


    click_link "Users"

    expect(page.current_path).to eq users_path
    expect(page).to have_content("Below we are present all our user")
    expect(page).to have_link("Mona Lisa")

    click_link "Mona Lisa"

    expect(page.current_path).to eq user_path(other_user)
    expect(page).to have_link("Test")

    click_link "Test"

    expect(page).to have_content("track-1")
    within(".track-1") do
      click_link 'add_track'
    end
  end

end