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

FactoryGirl.define do
  factory :playlist do
    name "Trance"
		description "Best Trance 2014"
		followers_count 1
		id_spotify "12345"
		spotify_type "playlist"
  end
end
