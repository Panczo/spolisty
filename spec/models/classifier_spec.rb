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

require 'rails_helper'

RSpec.describe Classifier, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
