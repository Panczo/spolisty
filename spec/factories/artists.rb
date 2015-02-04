# == Schema Information
#
# Table name: artists
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  spotify_id :string
#

FactoryGirl.define do
  factory :artist do
    name "MyString"
    spotify_id "1"
  end

end
