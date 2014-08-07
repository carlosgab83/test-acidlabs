class Artist < ActiveRecord::Base

  validates :name, presence: true
  validates :spotify_reference, presence: true
  validates :spotify_reference, uniqueness: true
    
  has_many :albums, inverse_of: :artist
  accepts_nested_attributes_for :albums
  
  #busca en spotify
  def Artist.remote_find_by_name(artist_name)
    artists = RSpotify::Artist.search(artist_name)
	return artists
	#OJO VER SI HAY QUE CAPTURAR EXCEPCIONES de TIMEOUT .. por tiempo no lo hice
  end
  
  #crea un nuevo objeto Artist con sus albums y tracks, esto objeto esta listo para ser guardado con save
  def Artist.new_artist_and_albums_and_tracks(artist_spotify_reference)
	remote_artist = RSpotify::Artist.find(artist_spotify_reference)
	artist_params = {name: remote_artist.name, spotify_reference: remote_artist.id, albums_attributes: fill_albums(remote_artist.albums)}
	artist = Artist.new(artist_params)
	return artist
  end#method
  
  #trae los detalles de los albumes de este artista
  def albums_details
    artist_id = self.id
	q1 = Album.select("albums.id as album_id, max(tracks.duration_ms) as duration_ms").joins(:tracks).where("albums.artist_id = :a1",{a1:artist_id}).group("albums.id").to_sql
    
	q2 = Track.select("tracks.album_id, tracks.name, tracks.duration_ms")
		.joins("inner join (#{q1}) as max_initial on tracks.album_id = max_initial.album_id and tracks.duration_ms = max_initial.duration_ms")
		.joins(:album)
		.where("albums.artist_id = :a2",{a2:artist_id}).to_sql
	
	Album.select("albums.name as album_name,release_date as release_date, avg(tracks_albums.popularity) as avg, max_complete.name as track_name, max_complete.duration_ms as max_duration_ms")
		 .joins("inner join (#{q2}) as max_complete on albums.id = max_complete.album_id")
		 .joins(:tracks)
		 .where("albums.artist_id = :a3",{a3:artist_id})
		 .group("albums.id").group("albums.release_date").group("max_complete.name").group("max_complete.duration_ms")
		 .order(:release_date)	 
  end
  
  def Artist.downloaded?(remote_artist_id)
	not Artist.where(spotify_reference:remote_artist_id ).empty?
  end
  
  private
  
  #llena el arreglo de albums desde los albumes remotos
  def Artist.fill_albums(remote_albums)
	remote_albums[0..9].collect do |remote_album|
		{
			name:remote_album.name,
			release_date:remote_album.release_date,
			spotify_reference:remote_album.id,
			tracks_attributes:fill_tracks(remote_album.tracks)
		}
	end#collect
  end
  
  #llena el arreglo de tracks desde los tracks remotos
  def Artist.fill_tracks(remote_tracks)
	remote_tracks[0..9].collect do |remote_track|
		{
			name:remote_track.name,
			spotify_reference:remote_track.id,
			duration_ms:remote_track.duration_ms,
			popularity:remote_track.popularity
		}
	end#collect
  end
  
  

  

end