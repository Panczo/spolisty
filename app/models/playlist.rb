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

	validates :user, :name, :spotify_type, presence: true
	validates :spotify_type, acceptance: { accept: 'playlist', message: "wrong spotify type" }

  def total_tracks_duration
    seconds = tracks.sum(:duration) / 1000
    Time.at(seconds).utc.strftime("%H:%M:%S")
  end

  def tracks_ids
    tracks.pluck(:track_number)
  end

  def owner
    self.user
  end

  def upload_tracks
    spotify_user = RSpotify::User.new(user.spotify_hash)
    playlist = spotify_user.create_playlist!(self.name)
    ids = tracks_ids
    playlist_tracks = RSpotify::Base.find(ids, 'track')
    playlist.add_tracks!(playlist_tracks)
  end

end
