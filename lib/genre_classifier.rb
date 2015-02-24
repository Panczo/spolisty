class GenreClassifier

  GENRESHASH = {
    "Alternative" => "Art Punk Alternative-Rock College Rock Experimental Rock Goth / Gothic Rock Grunge Hardcore Punk Hard Rock Indie Rock Lo-fi New Wave Progressive Rock Punk Shoegaze Steampunk",
    "Anime" => "Anime",
    "Blues" => "Acoustic Blues Chicago Blues Classic Blues Contemporary Blues Country Blues Delta Blues Electric Blues",
    "Children’s Music" => "Lullabies Sing-Along Stories",
    "Classical" => "Avant-Garde Baroque Chamber Music Chant Choral Classical Crossover Early Music High Classical Impressionist Medieval Minimalism Modern Composition Opera Orchestral Renaissance Romantic Wedding Music",
    "Comedy" => "Novelty Standup Comedy Vaudeville",
    "Commercial" => "Jingles TV Themes",
    "Country" => "Alternative-Country Bluegrass Contemporary Bluegrass Contemporary Country Country Gospel Country-Pop Honky Tonk Outlaw Country Traditional Bluegrass Traditional Country Urban Cowboy",
    "Dance"  =>  "Club / Club Dance Breakbeat Brostep Deep House Dubstep Electro House Exercise Garage Glitch-Hop Hardcore Hard Dance Hi-NRG / Eurodance House Jackin House Jungle / Drum’n’bass Regstep Techno Trance",
    "Disney" => "Disney",
    "Easy Listening" =>  "Bop Lounge Swing",
    "Electronic" => "8bit – aka 8-bit, Bitpop and Chiptune Ambient Bassline Chiptune Crunk Downtempo Drum & Bass Electro Electro-swing Electronica Electronic Rock Hardstyle IDM/Experimental Industrial Trip Hop",
    "Hip-Hop/Rap" =>  "Alternative-Rap Bounce Dirty South East Coast Rap Gangsta Rap Hardcore Rap Hip-Hop Latin-Rap Old School Rap Rap Turntablism Underground Rap West Coast Rap",
    "Holiday" => "Chanukah Christmas Christmas-Children’s Christmas-Classic Christmas-Classical Christmas-Jazz Christmas-Modern Christmas-Pop Christmas-R&B Christmas-Religious Christmas-Rock Easter Halloween Holiday-Other Thanksgiving",
    "Inspirational – Christian & Gospel" =>  "CCM Christian-Metal Christian-Pop Christian-Rap Christian-Rock Classic-Christian Contemporary Gospel Gospel-Christian & Gospel Praise & Worship Qawwali Southern-Gospel Traditional Gospel",
    "J-Pop" =>  "J-Rock J-Synth J-Ska J-Punk", 
    "Jazz" =>  "Acid Jazz Avant-Garde Jazz Bebop Big Band Blue Note Contemporary Jazz Cool Crossover Jazz Dixieland Ethio-jazz Fusion Gypsy-Jazz Hard Bop Latin-jazz Mainstream-Jazz Ragtime Smooth-Jazz Trad-Jazz",
    "Latin" =>  "Alternativo & Rock Latino Argentine tango Baladas y Boleros Bossa Nova Brazilian Contemporary Latin Flamenco / Spanish Flamenco Latin-Jazz Nuevo Flamenco Pop Latino Portuguese fado Raíces Reggaeton y Hip-Hop Regional Mexicano Salsa y Tropical",
    "New Age" =>  "Environmental Healing Meditation Nature Relaxation Travel",
    "Pop" =>  "Adult Contemporary Britpop Bubblegum-Pop Chamber-Pop Dance-Pop Dream-Pop Electro-Pop Orchestral-Pop Pop/Rock Power-Pop Soft-Rock Synthpop Teen-Pop",
    "R&B/Soul" => "Contemporary R&BDoo WopFunkModern SoulMotownNeo-SoulNorthern SouPsychedelic SoulQuiet StormSoulSoul-BluesSouthern-Soul",
    "Reggae" =>  "Dancehall Dub Roots Reggae Ska",
    "Rock" =>  "Acid Rock Adult-Oriented Rock Afro-Punk Adult-Alternative Alternative-Rock American Trad Rock Anatolian Rock Arena Rock Art Rock Blues-Rock British Invasion Death Metal / Black Metal Glam Rock Gothic Metal Hair Metal Hard Rock Metal Noise Rock Jam Bands Post Punk  Prog-Rock/Art Rock Psychedelic Rock & Roll Rockabilly Roots Rock Singer/Songwriter Southern Rock Surf Tex-Mex Time Lord Rock (Trock)",
    "Singer/Songwriter" =>  "Alternative-Folk Contemporary Folk Contemporary Singer/Songwriter Indie-Folk Folk-Rock Love-Song New Acoustic Traditional Folk",
    "Soundtrack" =>  "Foreign Cinema Musicals Original Score Soundtrack TV Soundtrack",
    "Tex-Mex / Tejano" =>  "Chicano Classic Conjunto Conjunto Progressive New Mex Tex-Mex",
    "Vocal" =>  "Acappella Barbershop Doo-wop Gregorian Chant Standards Traditional-Pop Vocal-Jazz Vocal-Pop",
    "World" => "Africa Afro-Beat Afro-Pop Asia Australia Cajun Calypso Caribbean Celtic Celtic Folk Contemporary Celtic Dangdut Drinking Songs Drone Europe France Hawaii Indian-Ghazal Indian-Pop Japan Japanese-Pop Klezmer Middle East North America Ode Polka Soca South Africa South America Traditional Celtic Worldbeat Zydeco"
  }

  def initialize(tracks)
    @tracks = tracks
  end

  def artist_spotify_ids
     @tracks.map {|tr| tr.artist.spotify_id}
  end

  def spotify_artists
    #Download artists from spotify 
    all_spotify_artsits = Array.new
    artist_spotify_ids.each_slice(40) do |artists_ids|
        art = RSpotify::Artist.find(artists_ids)
      all_spotify_artsits << art
    end
    all_spotify_artsits
  end

  def run
    spotify_artists.each do |artists|
      artists.each do |artist|
        next if artist.genres.blank?
        spotify_genre = artist.genres.join.first
        if selected = GENRESHASH.select { |k,v| v.include? spotify_genre }
          genre = Hash[*selected.first].keys.join
          raise :test
          
          tracks_from_playlist = @tracks.select{|tr| tr.artist.spotify_id == artist.id}
          tracks_from_playlist.each do |tr|
            spotify_genre = Genre.find_or_create_by(name: genre)
            tr.genre = spotify_genre
            tr.save
          end
        end
      end
    end
  end
end

