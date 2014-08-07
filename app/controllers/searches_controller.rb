class SearchesController < ApplicationController
  before_action :set_artist, only: [:show, :edit, :update, :destroy]

  
	def search
		@remote_artists = Array.new
	
	end
	
	def find
		artist_name = params[:artist_name]
		@remote_artists = Artist.remote_find_by_name(artist_name)
		render :search
	end
  
	def save
		artist_spotify_reference = params[:id]
		
			artist = Artist.new_artist_and_albums_and_tracks(artist_spotify_reference)
			if artist.save
				render :text=>"guardado"
			else
				render :text=>"no guardado"
				end
	end
	
	def borrar
		Track.all.each do |x|
			x.destroy
		end
		
		Album.all.each do |x|
			x.destroy
		end
		
		
		Artist.all.each do |x|
			x.destroy
		end
		
	end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artist
      @artist = Artist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def artist_params
      params.require(:artist).permit(:name, :spotify_reference, :created_at)
    end
end
