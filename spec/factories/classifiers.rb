# == Schema Information
#
# Table name: classifiers
#
#  id               :integer          not null, primary key
#  music_classifier :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  name             :string
#

FactoryGirl.define do
  factory :classifier do
    music_classifier "MyText"
  end

end
