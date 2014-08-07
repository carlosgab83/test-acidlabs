json.array!(@tracks) do |track|
  json.extract! track, :id, :name, :duration_ms, :popularity, :spotify_reference, :album_id, :created_at
  json.url track_url(track, format: :json)
end
