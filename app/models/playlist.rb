# == Schema Information
#
# Table name: playlists
#
#  id              :integer          not null, primary key
#  name            :string
#  description     :text
#  followers_count :integer
#  id_spotify      :string
#  spotify_type    :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :integer
#  count_of_tracks :integer          default("0"), not null
#  ownerlist       :string
#  image           :string
#

class Playlist < ActiveRecord::Base
  belongs_to :user
  has_many :tracks, dependent: :destroy

  validates :user, :name, :spotify_type, presence: true
  validates :spotify_type, acceptance: { accept: 'playlist', message: "wrong spotify type" }

  def total_tracks_duration
    seconds = tracks.sum(:duration) / 1000
    Time.at(seconds).utc.strftime("%H:%M:%S")
  end

  def tracks_ids
    tracks.pluck(:track_number)
  end

  def owner
    self.user
  end

  def special?
    special == true
  end

  def upload_tracks
    #Parse playlist spotify_id
    describe_playlist if id_spotify.blank?

    # If playlist "spolisty" exist
    if user.playlists.include? (self)
      playlistInSpotify = RSpotify::Playlist.find(user.spotify_id, id_spotify)
      spolistyTracksIds = playlistInSpotify.tracks.map(&:id)
      finalTracks = tracks_ids - spolistyTracksIds

      #If finalTracks empty(track from playlist was deleted) - replece all playlist
      #else add tracks to this playlist
      finalTracks.empty? ? replace_playlists(tracks_ids, playlistInSpotify) : addsTracks(finalTracks, playlistInSpotify)
    else
    # Else - create new playlist with name spolisty and add tracks 
      spotify_user = RSpotify::User.new(user.spotify_hash)
      playlist = spotify_user.create_playlist!(self.name)
      addsTracks(tracks_ids, playlist)
    end
  end

  private 

  def describe_playlist
    spotify_user = RSpotify::User.new(user.spotify_hash)
    playlists = spotify_user.playlists
    spolistyplaylist = playlists.select{|p| p.name == 'spolisty'}
    spolistyplaylist.blank? ? createSpolistyPlaylist(user) : addSpotifyId(spolistyplaylist)
  end

  def createSpolistyPlaylist(user)
    spotify_user = RSpotify::User.new(user.spotify_hash)
    spolistylist = spotify_user.create_playlist!('spolisty')
    addSpotifyId(spolistylist)
  end

  def addSpotifyId(playlist)
    self.id_spotify = playlist[0].id
    save
  end

  def addsTracks(ids, playlistInSpotify)
    playlist_tracks = RSpotify::Base.find(ids, 'track')
    playlistInSpotify.add_tracks!(playlist_tracks)
  end

  def replace_playlists(ids, playlistInSpotify)
    tracks = RSpotify::Base.find(ids, 'track')
    playlistInSpotify.replace_tracks!(tracks)
  end
end
