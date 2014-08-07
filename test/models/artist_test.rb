require 'test_helper'

class ArtistTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
    test "Busca remotamente un artista, dado un nombre de artista" do
		artists = Artist.remote_find_by_name("Bruno Mars")
		assert_not artists.empty?
    end

	test "Trae y guarda el artista, albums y tracks desde spotify, dado un spotify_id" do
		remote_artist = Artist.remote_find_by_name("Bruno Mars").first
		artist = Artist.new_artist_and_albums_and_tracks(remote_artist.id)
		artist.save
		assert_not artist.nil?
		assert_not artist.albums.empty?
		artist.albums.each do |albums|
			assert_not albums.tracks.empty?
		end
	end#test
	
	 test "comprueba funcionamiento del Album.albums_details(artist_id)" do
		remote_artist = Artist.remote_find_by_name("Bruno Mars").first
		artist = Artist.new_artist_and_albums_and_tracks(remote_artist.id)
		artist.save
		puts artist.id
		puts artist.name
		puts artist.spotify_reference
		puts artist.created_at
		artist.albums[0..2].each do |a|
			puts "-----new album------"
			puts a.id
			puts a.name
			puts a.release_date
			puts a.spotify_reference
			puts a.created_at
			puts a.artist_id
			a.tracks[0..2].each do |t|
				puts "    ---new track---"
				puts t.id
				puts t.name
				puts t.spotify_reference
				puts t.duration_ms
				puts t.popularity
				puts t.created_at
				puts t.album_id
			end#track
		end#albums
		
		albums_details = artist.albums_details
		albums_details.each do |a|
			puts "*****************"
			puts " #{a['album_name']},#{a['release_date']},#{a['avg']},#{a['track_name']},#{a['max_duration_ms']}"
		end
		puts albums_details.inspect
		assert_not albums_details.empty?
		
	end#test
	
end
