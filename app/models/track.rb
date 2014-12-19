# == Schema Information
#
# Table name: tracks
#
#  id          :integer          not null, primary key
#  name        :string
#  playlist_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Track < ActiveRecord::Base
  belongs_to :playlist, dependent: :destroy, counter_cache: :count_of_tracks

  validates :playlist, presence: true
end
