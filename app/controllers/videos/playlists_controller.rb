class Videos::PlaylistsController < ApplicationController
	before_action :set_playlist, only: :show

	def show
	end

	private
		def set_playlist
			@playlist = Playlist.find(params[:id])
			@videos = @playlist.videos
			@channel = @videos.first.channel
		end
end
