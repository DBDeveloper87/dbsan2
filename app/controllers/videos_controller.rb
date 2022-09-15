class VideosController < ApplicationController
	def index
		@videos = Video.all
	end

	def new
		@video = Video.new
	end

	def show
		@video = Video.find(params[:id])
	end

	def create
		@video = Video.create(video_params)

		if @video.save
			respond_to do |f|
				f.turbo_stream
			end
		end
	end

	private
		def video_params
			params.require(:video).permit(:original_upload)
		end	
end
