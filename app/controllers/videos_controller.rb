class VideosController < ApplicationController
	layout "videos"

	def index
		@videos = Video.all
	end

	def new
		@upload = Upload.new	
	end

	def edit
		@video = Video.find(params[:id])
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
			params.require(:video).permit(:title, :content_type, :upload_size, :original_upload)
		end	

		def success_json(video)
			[
				video: [
					id: video.id,
					title: video.title,
					content_type: video.content_type,
					upload_size: video.upload_size
				]
			]
		end

end
