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
#

class Playlist < ActiveRecord::Base
	belongs_to :user
  has_many :tracks, dependent: :destroy

	validates :user, :name, :id_spotify, :spotify_type, presence: true
	validates :spotify_type, acceptance: { accept: 'playlist', message: "wrong spotify type" }

  def total_tracks_duration
    seconds = tracks.sum(:duration) / 1000
    Time.at(seconds).strftime("%H:%M:%S")
  end
end
