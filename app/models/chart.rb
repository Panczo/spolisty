# == Schema Information
#
# Table name: charts
#
#  id           :integer          not null, primary key
#  name         :string
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  generated_at :datetime
#

class Chart < ActiveRecord::Base
  belongs_to :user
end
