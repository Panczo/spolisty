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

class User < ActiveRecord::Base
  serialize :spotify_hash

  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:spotify]
  
  attr_accessor :login

  has_many :playlists, dependent: :destroy
  has_many :tracks, through: :playlists

  validates :provider, :uid, presence: true


  def image?
    !image.nil?
  end

  def import_playlist
    spotify_user = RSpotify::User.new(spotify_hash)
    #Import playlists through RSpotify
    spotify_playlists = spotify_user.playlists
    spotify_playlists.each do |p|
      #create Playlist
      play = playlists.create(name: p.name, id_spotify: p.id, spotify_type: p.type, ownerlist: p.owner.display_name)
      #If current user is a owner of playlist ==> import tracks
      if p.owner.display_name == spotify_user.display_name
        #Import tracks from particular playlists through RSpotify
        @finaltracks = @offsety = []

        parse_songs(p)

        @finaltracks.each do |tr|
          play.tracks.create(name: tr.name)
        end
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth["provider"], uid: auth["uid"]).first_or_create do |user|
          user.email = auth["info"]["email"]
          user.password = Devise.friendly_token[0,20]
          user.name = auth["info"]["display_name"] unless auth["info"]["display_name"].nil?
          user.image = auth["info"]["images"][0]["url"] unless auth["info"]["images"].blank?
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

  private

  def parse_songs(playlist, offset=0)
    songs = playlist.tracks(limit: 100, offset: offset)
    @finaltracks += songs
    @offsety << offset

    if songs.size == 100 
      parse_songs(playlist, @offsety.last + 100)
    end
  end

end
