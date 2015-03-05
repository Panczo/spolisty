# == Schema Information
#
# Table name: spotify_genres
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :spotify_genre do
    name "MyString"
  end

end
