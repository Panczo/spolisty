class Rewiew < ActiveRecord::Base
  belongs_to :user
  belongs_to :playlist

  validates :user, :playlist, presence: true
end
