# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  provider               :string(255)
#  uid                    :string(255)
#  image                  :text
#  name                   :string(255)
#  spotify_hash           :text
#

require 'rails_helper'

RSpec.describe User, :type => :model do

	it "is has a valid factory" do
		expect(create(:user)).to be_valid
	end

	it "it invalid without provider" do
		user = build(:user, provider: nil, uid: nil, name: nil)
		user.valid?
		expect(user.errors.size).to eq(3)
	end

end
