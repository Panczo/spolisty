# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime
#  updated_at             :datetime
#  provider               :string
#  uid                    :string
#  image                  :text
#  name                   :string
#  spotify_hash           :text
#

require 'rails_helper'

RSpec.describe User, :type => :model do
	it { should serialize(:spotify_hash) }

	it "is has a valid factory" do
		expect(create(:user)).to be_valid
	end

	it "it invalid without provider" do
		user = build(:user, provider: nil, uid: nil, name: nil)
		user.valid?
		expect(user.errors.size).to eq(2)
	end

	it '#import_playlist'


end
