module ArtistsHelper

	def error_helper
		if @error
			html = "<div class='error'> Oops, An Error has occurred!, try another Artist </div>"
			return html.html_safe
		end
	end

end
