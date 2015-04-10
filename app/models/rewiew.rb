class Rewiew < ActiveRecord::Base
  belongs_to :user
  belongs_to :playlist

  validates :user, :playlist, :rating, :comment, presence: true
  validates :rating, numericality: { only_integer: true, greater_than: 0 }
end
