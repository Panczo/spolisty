class GenreClassifier

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
        SpotifyGenre.create(name: artist.genres.join)
        spotify_genres = artist.genres
        spolisty_genre = classify(spotify_genres)

        tracks_from_playlist = @tracks.select{|tr| tr.artist.spotify_id == artist.id}
        tracks_from_playlist.each do |tr|
          unless spolisty_genre == "Brak"
            spolisty_classify_genre = Genre.find_by(name: spolisty_genre)
            tr.genre = spolisty_classify_genre
            tr.spotify_genre = spotify_genres
            tr.save
          end
        end
      end
    end
  end


  private

  def classify(genres)
    if genres.any? {|w| 
      [
        "harmonica blues", "louisiana blues",
        "memphis blues", "swamp blues", "texas blues",
        "punk blues", "memphis blues", "texas blues", "traditional blues", 
        "electric blues", "modern blues", "soul blues", "texas blues",
        "traditional blues", "bluegrass", "boogie",
        "blues", "blueselectric",
        "bluesmodern", "bluessoul", "bluestexas",
        "bluestraditional"
      ].include? w }
      return "blues"
    elsif genres.any? {|w| 
      [
        "classical", "orchestral", "opera", "classical performance",
        "classical christmas", "deep orchestral"
      ].include? w }
      return "classical"
    elsif genres.any? {|w| 
      [
        "outlaw country", "traditional country", "country christmas",
        "alternative country", "country rock", "cowpunk",
        "roots rock", "country", "countryroots"
      ].include? w }
      return "country"
    elsif genres.any? {|w| 
      [
        "doo-wop", "opm", "cubaton", "singer-songwriter", "brazilian indie",
        "freak folk", "new weird america", "soundtrack", "international",
        "rumba", "freak",
        "folknew", "weird", "america", "british",
        "folksinger-songwriter", "songwriter" 
      ].include? w }
      return "international"
    elsif genres.any? {|w| 
      [
        "hard bop", "piano blues", "stride", "boogie-woogie",
        "contemporary post-bop", "latin jazz", "big band", "swing",
        "new orleans jazz", "jazz christmas", "vocal jazz",
        "contemporary", "post-bopjazz", "christmasjazz", "funkjazz",
        "fusion", "bebopcontemporary", "post-bopcool", "jazzhard",
        "bopjazz", "jazz", "jam", "band", "big",
        "bandswing", "bebopcool", "jazzhard", "bopjazzsoul",
        "jazz" 
      ].include? w }
      return "jazz"
    elsif genres.any? {|w| 
      [
        "latin", "new romantic", "latin alternative"
      ].include? w }
      return "latin"
    elsif genres.any? {|w| 
      [
        "brill building pop", "spanish pop", "polish pop", "chamber pop",
        "bebop", "hard bop", "classic russian pop", "pop punk", "punk christmas",
        "freestyle", "garage pop", "pop", "disco", "teen pop", "synthpop", "teen pop",
        "shimmer pop", "stomp pop", "pop rap", "pop christmas"
      ].include? w }
      return "pop"
    elsif genres.any? {|w| 
      [
        "soul christmas", "brill building pop", "motown", "soul",
        "soul christmas", "chicago soul", "christmas", "chicago", "soulmotownnorthern", "soulsoul",
        "christmassoul", "indie", "freestyle", "soul", "r&b",
        "rb", "funk", "hi", "nrg", "soulmotownsoul", "motownsoulsoul" 
      ].include? w }
      return "soul"
    elsif genres.any? {|w| 
      [
        "new jack smooth", "juggalo", "detroit hip hop", "g funk", "west coast rap", 
        "underground hip hop", "hip hop","old school hip hop",
        "dirty south rap", "pop rap", "southern hip hop",
        "trap music", "gangster", "rap", "hip", "hop", "coast",
        "funkgangster", "rapwest", "skaska", "punk", "dutch hip hop"
      ].include? w }
      return "hip-hop"
    elsif genres.any? {|w| 
      [
        "reggae", "rag"
      ].include? w }
      return "reggae"
    elsif genres.any? {|w| 
      [
        "rock-and-roll", "rockabilly", 
        "lovers rock", "german metal", "permanent wave", "ska",
        "ska punk", "grunge",
        "alternative rock", "venezuelan rock", "colombian rock",
        "industrial", "industrial metal", "industrial rock",
        "dance rock", "psychedelic rock", "soft rock",
        "folk rock", "roots rock", "album rock",
        "classic funk rock", "glam rock", "funk rock",
        "hard rock", "heavy christmas", "blues-rock",
        "british blues", "classic rock",
        "rock", "punk", "metal", "hard", "rockpermanent",
        "art rock"
      ].include? w }
      return "rock"
    elsif genres.any? {|w| 
      [
        "comic", "comedy", "deep comedy"
      ].include? w }
      return "comedy"
    elsif genres.any? {|w| 
      [
        "electronic", "deep uplifting trance", "ambient trance",
        "edm", "houseprogressive", "trancetranceuplifting",
        "uplifting", "ambient", "dubstep", "house", "lounge",
        "trance", "progressive", "tranceprogressive", "electronic"
      ].include? w }
      return "electronic"
    else
      return "Brak"
    end
  end

end

=begin

  def classifier
    Classifier.find_or_create_by(name: "Music Classifier") do |cls|
      cls.music_classifier_will_change!
      cls.music_classifier = StuffClassifier::Bayes.new("Music_Classifier", :stemming => false)
      cls.music_classifier.train(:alternative, "Art-Punk Alternative-Rock College-Rock Experimental-Rock Goth / Gothic Rock Grunge Hardcore Punk Hard-Rock Indie-Rock Lo-fi New Wave Progressive-Rock Punk Shoegaze Steampunk")
      cls.music_classifier.train(:country, "Alternative-Country Bluegrass Contemporary Bluegrass Contemporary Country Country Gospel Country-Pop Honky Tonk Outlaw Country Traditional Bluegrass Traditional Country Urban Cowboy")
      cls.music_classifier.train(:dance, "Club / Club Dance Breakbeat Brostep Deep House Dubstep Electro House Exercise Garage Glitch-Hop Hardcore Hard Dance Hi-NRG / Eurodance House Jackin House Jungle / Drum’n’bass Regstep Techno Trance")
      cls.music_classifier.train(:anime, "Anime")
      cls.music_classifier.train(:easy_listening, "Bop Lounge Swing")
      cls.music_classifier.train(:disney, "Disney")
      cls.music_classifier.train(:electronic, "8bit – aka 8-bit, Bitpop and Chiptune Ambient Bassline Chiptune Crunk Downtempo Drum & Bass Electro Electro-swing Electronica Electronic Rock Hardstyle IDM/Experimental Industrial Trip Hop")
      cls.music_classifier.train(:commercial, "Jingles TV Themes")
      cls.music_classifier.train(:hip_hop, "Alternative-Rap Bounce Dirty South East Coast Rap Gangsta Rap Hardcore Rap Hip-Hop Latin-Rap Old School Rap Rap Turntablism Underground Rap West Coast Rap")
      cls.music_classifier.train(:comedy, "Novelty Standup Comedy Vaudeville")
      cls.music_classifier.train(:inspirational_gospel, "CCM Christian-Metal Christian-Pop Christian-Rap Christian-Rock Classic-Christian Contemporary Gospel Gospel-Christian & Gospel Praise & Worship Qawwali Southern-Gospel Traditional Gospel")
      cls.music_classifier.train(:holiday, "Chanukah Christmas Christmas-Children’s Christmas-Classic Christmas-Classical Christmas-Jazz Christmas-Modern Christmas-Pop Christmas-R&B Christmas-Religious Christmas-Rock Easter Halloween Holiday-Other Thanksgiving")
      cls.music_classifier.train(:children_music, "Lullabies Sing-Along Stories")
      cls.music_classifier.train(:j_pop, "J-Rock J-Synth J-Ska J-Punk")
      cls.music_classifier.train(:jazz, "Acid Jazz Avant-Garde Jazz Bebop Big Band Blue Note Contemporary Jazz Cool Crossover Jazz Dixieland Ethio-jazz Fusion Gypsy-Jazz Hard Bop Latin-jazz Mainstream-Jazz Ragtime Smooth-Jazz Trad-Jazz")
      cls.music_classifier.train(:classical, "Avant-Garde Baroque Chamber Music Chant Choral Classical Crossover Early Music High Classical Impressionist Medieval Minimalism Modern Composition Opera Orchestral Renaissance Romantic Wedding Music")
      cls.music_classifier.train(:blues, "Acoustic-Blues Chicago-Blues Classic-Blues Contemporary-Blues Country-Blues Delta-Blues Electric-Blues")
      cls.music_classifier.train(:latin, "Alternativo & Rock Latino Argentine tango Baladas y Boleros Bossa Nova Brazilian Contemporary Latin Flamenco / Spanish Flamenco Latin-Jazz Nuevo Flamenco Pop Latino Portuguese fado Raíces Reggaeton y Hip-Hop Regional Mexicano Salsa y Tropical")
      cls.music_classifier.train(:new_age, "Environmental Healing Meditation Nature Relaxation Travel")
      cls.music_classifier.train(:pop, "Adult Contemporary Britpop Bubblegum-Pop Chamber-Pop Dance-Pop Dream-Pop Electro-Pop Orchestral-Pop Pop/Rock Power-Pop Soft-Rock Synthpop Teen-Pop")
      cls.music_classifier.train(:rb_soul, "Contemporary R&BDoo WopFunkModern SoulMotownNeo-SoulNorthern SouPsychedelic SoulQuiet StormSoulSoul-BluesSouthern-Soul")
      cls.music_classifier.train(:reggae, "Dancehall Dub Roots Reggae Ska")
      cls.music_classifier.train(:rock, "Acid Rock Adult-Oriented Rock Afro-Punk Adult-Alternative Alternative-Rock American Trad Rock Anatolian Rock Arena Rock Art Rock Blues-Rock British Invasion Death Metal / Black Metal Glam Rock Gothic Metal Hair Metal Hard Rock Metal Noise Rock Jam Bands Post Punk  Prog-Rock/Art Rock Psychedelic Rock & Roll Rockabilly Roots Rock Singer/Songwriter Southern Rock Surf Tex-Mex Time Lord Rock (Trock)")
      cls.music_classifier.train(:singer, "Alternative-Folk Contemporary Folk Contemporary Singer/Songwriter Indie-Folk Folk-Rock Love-Song New Acoustic Traditional Folk")
      cls.music_classifier.train(:texmex_tehano, "Chicano Classic Conjunto Conjunto Progressive New Mex Tex-Mex")
      cls.music_classifier.train(:soundtrack, "Foreign Cinema Musicals Original Score Soundtrack TV Soundtrack")
      cls.music_classifier.train(:vocal, "Acappella Barbershop Doo-wop Gregorian Chant Standards Traditional-Pop Vocal-Jazz Vocal-Pop")
      cls.music_classifier.train(:world, "Africa Afro-Beat Afro-Pop Asia Australia Cajun Calypso Caribbean Celtic Celtic Folk Contemporary Celtic Dangdut Drinking Songs Drone Europe France Hawaii Indian-Ghazal Indian-Pop Japan Japanese-Pop Klezmer Middle East North America Ode Polka Soca South Africa South America Traditional Celtic Worldbeat Zydeco")
      cls.save!
    end

  end
spolisty_genre = classifier.music_classifier.classify spotify_genre=end
=end