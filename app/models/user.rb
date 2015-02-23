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

class User < ActiveRecord::Base
  serialize :spotify_hash

  devise :database_authenticatable,
        :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:spotify]
  
  attr_accessor :login

  has_many :playlists, dependent: :destroy
  has_many :tracks, through: :playlists
  has_one :chart

  validates :provider, :uid, presence: true


  def image?
    !image.nil?
  end

  def nick
    name.blank? ? nick_from_email : name
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
          #Ommit track when is on playlist
          next if play.tracks.include? tr
          #create playlist tracks
          track = play.tracks.create(name: tr.name, 
                             track_number: tr.id, 
                             duration: tr.duration_ms,
                             user: self)
          #Add artist and album for track
          parse_artist(track, tr)
          parse_album(track, tr)
         
          #Add image to playlist
          if play.image.nil?
            play.image = tr.album.images[1]["url"]
            play.save
          end
        end
      end
    end
  end

  def generateChart
    g = GenreClassifier.new(tracks_with_artist, self)
    g.run
=begin
    tracks.each do |tr|
      next if !tr.genre.nil?
      spotify_artist = RSpotify::Artist.find(tr.artist.spotify_id)
      next if spotify_artist.genres.blank?
      spotify_genre = Genre.find_or_create_by(name: spotify_artist.genres.first)
      tr.genre = spotify_genre
      tr.save
    end
=end
  end

  def tracks_with_artist
    tracks.includes(:artist)
  end

  def self.from_omniauth(auth)
    where(provider: auth["provider"], uid: auth["uid"]).first_or_create do |user|
          user.email = auth["info"]["email"]
          user.password = Devise.friendly_token[0,20]
          user.name = auth["info"]["display_name"] unless auth["info"]["display_name"].nil?
          user.image = auth["info"]["images"][0]["url"] unless auth["info"]["images"].blank?
          user.spotify_id = auth["info"]["id"]
    end
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(email) = :value", {value: login.downcase}]).first
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

  def nick_from_email
    email.split("@").first
  end

  def parse_artist(track, spotify_track)
    artist = Artist.find_or_create_by(name: spotify_track.artists.first.name)
    if track.artist.blank?
      track.artist = artist
      artist.spotify_id = spotify_track.artists.first.id
      artist.save
      track.save
    end
  end

  def parse_album(track, spotify_track)
    album = Album.find_or_create_by(name: spotify_track.album.name)
    if track.album.blank?
      track.album = album
      track.save
    end
  end
end
