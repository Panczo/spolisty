genres = [
  'alternative', 'country' ,'dance', 'anime', 'easy_listening', 'disney', "electronic", 'commercial', 'hip_hop', 'comedy',
  'inspirational_gospel', 'holiday', 'children_music', 'j_pop', 'jazz', 'classical', 'blues', 'latin', 
  'new_age', 'pop', 'rb_soul'
]

genres.each do |g|
  Genre.create(name: g)
end