class ArtistsController < ApplicationController
  before_action :set_artist, only: [:show, :edit, :update, :destroy]

  def search
    @remote_artists = Array.new
  end
  
  def find
		@remote_artist_name = params[:remote_artist_name]
		@error = params[:error]
		@remote_artists = Artist.remote_find_by_name(@remote_artist_name)
		render :search
  end
  
  def clear
	Track.all.each {|x|x.destroy}
	Album.all.each {|x|x.destroy}
	Artist.all.each {|x|x.destroy}
	redirect_to :artists
  end
  
  # GET /artists
  # GET /artists.json
  def index
    @artists = Artist.all
  end

  # GET /artists/1
  # GET /artists/1.json
  def show
  end



  # POST /artists
  # POST /artists.json
  def create
	@remote_artist_name = params[:remote_artist_name]
	artist_spotify_reference = params[:artist_spotify_reference]
	@artist = Artist.new_artist_and_albums_and_tracks(artist_spotify_reference)
	if @artist.save
		redirect_to :action=> 'find', :remote_artist_name => @remote_artist_name 
	else
		redirect_to :action=> 'find', :remote_artist_name => @remote_artist_name , :error=>true
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
