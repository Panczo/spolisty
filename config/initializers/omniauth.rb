Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"], scope: 'playlist-read-private playlist-modify-public playlist-modify-private user-read-private user-read-email'
end