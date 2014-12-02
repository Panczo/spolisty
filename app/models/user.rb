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

class User < ActiveRecord::Base
  serialize :spotify_hash

  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:spotify]
  
  attr_accessor :login

  def self.from_omniauth(auth)
    spotify_user = RSpotify::User.new(auth)
    where(provider: auth["provider"], uid: auth["uid"]).first_or_create do |user|
          user.email = auth["info"]["email"]
          user.password = Devise.friendly_token[0,20]
          user.name = auth["info"]["display_name"]   
          user.image = auth["info"]["images"][0]["url"]
          user.spotify_hash = spotify_user.to_hash
      end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.spotify_data"] && session["devise.spotify_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", {value: login.downcase}]).first
    else
      where(conditions).first
    end
  end


  devise authentication_keys: [:login]

end
