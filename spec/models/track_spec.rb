# == Schema Information
#
# Table name: tracks
#
#  id            :integer          not null, primary key
#  name          :string
#  playlist_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  track_number  :string
#  duration      :integer
#  artist_id     :integer
#  album_id      :integer
#  genre_id      :integer
#  user_id       :integer
#  spotify_genre :string
#

require 'rails_helper'

RSpec.describe Track, :type => :model do
  let(:track) { build(:track) }

  it '#track_duration' do
    expect(track.track_duration).to eq("01:00")
  end
end
