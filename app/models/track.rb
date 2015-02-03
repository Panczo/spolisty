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

class Track < ActiveRecord::Base
  default_scope { order('updated_at DESC') }

  belongs_to :playlist, counter_cache: :count_of_tracks
  belongs_to :artist
  belongs_to :album
  belongs_to :genre

  validates :playlist, :name, :track_number, presence: true

  def track_duration
    seconds = duration / 1000
    Time.at(seconds).utc.strftime("%M:%S")
  end

end
