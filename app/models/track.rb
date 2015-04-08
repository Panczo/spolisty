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

class Track < ActiveRecord::Base
  default_scope { order('updated_at DESC') }
  scope :classified, -> { includes(:genre, :artist, :album, :playlist).where("genre_id IS NOT NULL") }
  scope :unclassified, -> { includes(:genre).where("genre_id IS NULL") }

  belongs_to :playlist, counter_cache: :count_of_tracks
  belongs_to :artist
  belongs_to :album
  belongs_to :genre
  belongs_to :user

  validates :playlist, :name, :track_number, presence: true

  def track_duration
    seconds = duration / 1000
    Time.at(seconds).utc.strftime("%M:%S")
  end

end
