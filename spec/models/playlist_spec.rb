# == Schema Information
#
# Table name: playlists
#
#  id              :integer          not null, primary key
#  name            :string
#  description     :text
#  followers_count :integer
#  id_spotify      :string
#  spotify_type    :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :integer
#  count_of_tracks :integer          default("0"), not null
#  ownerlist       :string
#  image           :string
#  special         :boolean          default("false")
#

require 'rails_helper'

RSpec.describe Playlist, :type => :model do

	it "is has a valid factory" do
		user = create(:user)
		expect(create(:playlist, user: user)).to be_valid
	end

	it 'is invalid without user' do
		expect(build(:playlist)).to_not be_valid
	end

	it 'is invalid without name,  spotify_type' do
		play = build(:playlist, user: create(:user), name: '', spotify_type: '')
		expect(play).to_not be_valid
		expect(play.errors.size).to eq 3
	end

	it 'is invalid with wrong spotify_type' do
		play = build(:playlist, user: create(:user), spotify_type: 'track')

		expect(play).to_not be_valid
		expect(play.errors[:spotify_type]).to include("wrong spotify type")
	end

	it '#total_tracks_duration' do
		play = create(:playlist, user: create(:user))
		3.times do
			create(:track, playlist: play)
		end

		expect(play.total_tracks_duration).to eq("00:03:00")
	end

	it '#tracks_ids' do
		play = create(:playlist, user: create(:user))
		3.times do |n|
			create(:track, track_number: "#{n}", playlist: play)
		end

		expect(play.tracks_ids).to eq(['2','1','0']) 
	end

	it '#special?' do
		expect(build(:playlist)).to_not be_special

		play = build(:playlist, special: true)
		expect(play).to be_special
		expect(play.special?).to be_truthy
	end

end
