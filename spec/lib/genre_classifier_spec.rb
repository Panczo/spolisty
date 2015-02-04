require 'rails_helper'
require 'genre_classifier'

describe "genre_classifier" do
  before(:each) do
    @user = FactoryGirl.create(:user, email: 'pjp@pjp.com')
    play = FactoryGirl.create(:playlist, user: @user)
    artist = FactoryGirl.create(:artist)
    3.times do 
      FactoryGirl.create(:track, user: @user, playlist: play, artist: artist)
    end
  end

  it "needs a tracks objects to initialize" do
    expect { GenreClassifier.new }.to raise_error(ArgumentError)
  end

  it "valid with argument" do
    genre = GenreClassifier.new(@user.tracks)
    expect(genre).to be_a GenreClassifier
  end

  it "#artist_spotify_ids" do
    genre = GenreClassifier.new(@user.tracks) 

    expect(genre.artist_spotify_ids).to eq(['1', '1', '1'])
  end
end