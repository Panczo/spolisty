# == Schema Information
#
# Table name: tracks
#
#  id           :integer          not null, primary key
#  name         :string
#  playlist_id  :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  track_number :string
#  duration     :integer
#  artist_id    :integer
#  album_id     :integer
#  genre_id     :integer
#

FactoryGirl.define do
  factory :track do
    sequence(:name) { |n| "Track name-#{n}"}
    sequence(:track_number) { |n| "12345" + "#{n}"}

    duration 60000
  end

end
