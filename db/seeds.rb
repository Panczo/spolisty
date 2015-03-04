genres = [
  'blues', 'classical', 'country', 'electronic',
  'international', 'jazz',
  'latin', 'pop', 'soul', 'hip-hop',
  'reggae', 'rock', 'comedy'
]

genres.each do |g|
  Genre.create(name: g)
end