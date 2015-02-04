class GenreClassifier

  def initialize(tracks)
    @tracks = tracks
  end

  def artist_spotify_ids
     @tracks.map {|tr| tr.artist.spotify_id}
  end

  def spotify_artists
    all = []
    artist_spotify_ids.find_each(start: 0, batch_size: 40) do |artists_ids|
        art = RSpotify::Artist.find(artists_ids)
      all << art
    end
    raise :test
  end
end