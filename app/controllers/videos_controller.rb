class VideosController < ApplicationController
	before_action :authenticate_user!, only: [:index, :new, :edit, :create, :update]
	layout "channel", only: [:index, :show]

	def index
		@subdomain = Subdomain.find_by(slug: request.subdomain)
		@channel = @subdomain.channel
		@videos = @channel.videos.all
	end

	def new
		@upload = Upload.new	
	end

	def edit
		@video = Video.find(params[:id])
	end

	def show
		
		@video = Video.find(params[:id])
		@meta_title = "#{@video.title} | #{@video.channel.name}"
		@meta_og_type = "video.movie"
		@meta_og_url = video_url(@video)
		@meta_og_image = "https://storage.googleapis.com/dbsan-public/poster.png"
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

		

end
