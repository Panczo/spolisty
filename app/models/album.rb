# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  image      :text
#

class Album < ActiveRecord::Base
  has_many :tracks

  validates :name, presence: true
end
