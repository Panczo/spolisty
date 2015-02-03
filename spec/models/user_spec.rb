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
#  spotify_id             :string
#  chartgeneratecount     :integer          default("0")
#  chartgeneratetime      :datetime
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


  it '#nick_from_email' do
    user = build(:user, email: 'test@example.com', name: nil)
    user2 = build(:user, email: 'test1@example.com', name: 'Frank')
    expect(user.nick).to eq('test')
    expect(user2.nick).to eq('Frank')
  end

  describe '#image?' do
    before(:each) do
      @user = build(:user, image: 'http://dummyimage.com/600x400/000/fff')
    end
    
    it "return true" do
      expect(@user.image?).to be_truthy
    end

    it "return false" do
      @user.image = nil
      expect(@user.image?).to be_falsey
    end
  end

	describe '#import_playlist', :vcr => true do
		before(:each) do	
			@user = VCR.use_cassette('user_spotify_hash') do
				RSpotify::User.find('testsanczo')
			end
		end

		it 'should find user with correct playlists' do
		  client_id = '5ac1cda2ad354aeaa1ad2693d33bb98c'
			client_secret = '155fc038a85840679b55a1822ef36b9b'
			VCR.use_cassette('authenticate:client') do
				RSpotify.authenticate(client_id, client_secret)
			end
      playlists = VCR.use_cassette('user:testsanczo:playlists:limit:20:offset:0') do
        @user.playlists
      end

      expect(playlists)             .to be_an Array
      expect(playlists.size)        .to eq 0
    end
	end
end
