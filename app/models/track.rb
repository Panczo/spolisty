class Track < ActiveRecord::Base
  belongs_to :playlist, dependent: :destroy, counter_cache: :count_of_tracks

  validates :playlist, presence: true
end
