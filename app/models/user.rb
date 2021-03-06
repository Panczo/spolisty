# == Schema Information
#
# Table name: users
#
#  id                      :integer          not null, primary key
#  email                   :string           default(""), not null
#  encrypted_password      :string           default(""), not null
#  reset_password_token    :string
#  reset_password_sent_at  :datetime
#  remember_created_at     :datetime
#  sign_in_count           :integer          default(0), not null
#  current_sign_in_at      :datetime
#  last_sign_in_at         :datetime
#  current_sign_in_ip      :string
#  last_sign_in_ip         :string
#  created_at              :datetime
#  updated_at              :datetime
#  provider                :string
#  uid                     :string
#  image                   :text
#  name                    :string
#  spotify_hash            :text
#  spotify_id              :string
#  chartgeneratecount      :integer          default(0)
#  chartgeneratetime       :datetime
#  about                   :text
#  rank                    :string
#  last_download_playlists :datetime
#

class User < ActiveRecord::Base
  after_create :create_spolisty_list
  attr_accessor :login
  serialize :spotify_hash
  
  devise  :database_authenticatable,
          :registerable,
          :rememberable,
          :trackable,
          :validatable,
          :omniauthable,
          :omniauth_providers => [:spotify]

  has_many :playlists, dependent: :destroy
  has_many :tracks, through: :playlists
  has_many :reviews, through: :playlists, dependent: :destroy
  has_many :charts
  has_many :genres, through: :tracks
  
  has_many :active_relationships, 
            class_name: "Relationship",
            foreign_key: "follower_id",
            dependent: :destroy
  has_many :passive_relationships, 
            class_name: "Relationship",
            foreign_key: "followed_id",
            dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships

  validates :provider, :uid, presence: true

  scope :ranked_users, -> (user) { User.where(rank: user.rank).where.not(id: user.id).limit(5) }

  acts_as_messageable

  devise authentication_keys: [:login]

  def sorted_tracks
    sorted_genre ||= []
    genres.uniq.each do |g|
      counted_tracks = tracks.where(genre: g).size
      gs = []
      gs << g.name << counted_tracks
      sorted_genre << gs
    end
    sorted_genre.sort_by!{|x| x[1]}.reverse!
  end

  def image?
    !image.nil?
  end

  def nick
    name.blank? ? nick_from_email : name
  end

  def import_playlist
    playlists.destroy_all if playlists.any?
    
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
          next if play.tracks.include? tr || tr.id.blank?
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
    g = GenreClassifier.new(tracks_with_artist)
    g.run
    classify_rank
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

  def rank_explorer
    if rank.blank? || rank == 'not enough data'
      rank = 'not enough data'
    else 
      rank = self.rank.capitalize + " Explorer"
    end
  end

  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def classify_rank
    new_rank = sorted_tracks.empty? ? 'not enough data' : sorted_tracks.first[0]
    update_attribute(:rank, new_rank)
  end


  def mailboxer_email(user)
    self.email
  end

  
  private

  def create_spolisty_list
    playlists.create(name: 'spolisty', special: true, spotify_type: 'playlist')
  end

  def nick_from_email
    email.split("@").first
  end

  def parse_songs(playlist, offset=0)
    songs = playlist.tracks(limit: 100, offset: offset)
    @finaltracks += songs
    @offsety << offset

    if songs.size == 100 
      parse_songs(playlist, @offsety.last + 100)
    end
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
      if spotify_track.album.images.empty?
        album.image = "Not defined"
      else
        album.image = spotify_track.album.images.first["url"]
      end
      album.save!
      track.album = album
      track.save!
    end
  end
end
