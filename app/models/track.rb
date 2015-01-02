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
#

class Track < ActiveRecord::Base
  belongs_to :playlist, counter_cache: :count_of_tracks

  validates :playlist, :name, :track_number, presence: true

  def track_duration
    seconds = duration / 1000
    Time.at(seconds).strftime("%M:%S")
  end

end
