require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, Figaro.env.spotify_client_id, Figaro.env.spotify_client_secret, scope: 'user-follow-read streaming playlist-read-private user-read-email playlist-modify-public user-library-read user-library-modify'
end