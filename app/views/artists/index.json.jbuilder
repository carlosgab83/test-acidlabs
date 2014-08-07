json.array!(@artists) do |artist|
  json.extract! artist, :id, :name, :spotify_reference, :created_at
  json.url artist_url(artist, format: :json)
end
