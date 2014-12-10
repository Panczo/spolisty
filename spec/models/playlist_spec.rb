# == Schema Information
#
# Table name: playlists
#
#  id              :integer          not null, primary key
#  name            :string
#  description     :text
#  followers_count :integer
#  id_spotify      :string
#  type            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :integer
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

	it 'is invalid without name, id_spotify, spotify_type' do
		play = build(:playlist, user: create(:user), name: '', id_spotify: '', spotify_type: '')
		expect(play).to_not be_valid
		expect(play.errors.size).to eq 3
	end

	it 'is invalid with wrong spotify_type' do
		play = build(:playlist, user: create(:user), spotify_type: 'track')

		play.valid?
		expect(play).to_not be_valid
		expect(play.errors[:spotify_type]).to include("wrong spotify type")
	end

end
