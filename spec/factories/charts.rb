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

FactoryGirl.define do
  factory :chart do
    name "MyString"
user_id 1
  end

end
