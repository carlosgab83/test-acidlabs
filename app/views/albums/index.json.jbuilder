json.array!(@albums) do |album|
  json.extract! album, :id, :name, :release_date, :spotify_reference, :artist_id, :created_at
  json.url album_url(album, format: :json)
end
