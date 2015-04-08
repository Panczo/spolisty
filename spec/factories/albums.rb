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

FactoryGirl.define do
  factory :album do
    name "MyString"
  end

end
