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

class Classifier < ActiveRecord::Base
  serialize :music_classifier, StuffClassifier::Bayes
end
