# == Schema Information
#
# Table name: charts
#
#  id         :integer          not null, primary key
#  name       :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Chart < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
end
