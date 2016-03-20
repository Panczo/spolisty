# == Schema Information
#
# Table name: reviews
#
#  id          :integer          not null, primary key
#  rating      :integer
#  comment     :text
#  user_id     :integer
#  playlist_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :playlist

  validates :user, :playlist, :rating, :comment, presence: true
  validates :rating, numericality: { only_integer: true, greater_than: 0 }
end
