class Track < ActiveRecord::Base
  belongs_to :playlist

  validates :playlist, presence: true
end
