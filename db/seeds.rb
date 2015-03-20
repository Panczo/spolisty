=begin
genres = [
  'blues', 'classical', 'country', 'electronic',
  'international', 'jazz',
  'latin', 'pop', 'soul', 'hip-hop',
  'reggae', 'rock', 'comedy'
]

genres.each do |g|
  Genre.create(name: g)
end
=end

25.times do |n|
  User.create!(name: Faker::Name.name, email: Faker::Internet.email, image: Faker::Avatar.image, provider: "spotify", uid: "#{n}", password: 'test1234', password_confirmation: 'test1234' )
end