json.array!(@rewiews) do |rewiew|
  json.extract! rewiew, :id, :rating, :comment, :user_id, :playlist_id
  json.url rewiew_url(rewiew, format: :json)
end
