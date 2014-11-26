# == Schema Information
#
# Table name: subscribes
#
#  id         :integer          not null, primary key
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :subscribe do
    email "test123@gmail.com"
  end

end
