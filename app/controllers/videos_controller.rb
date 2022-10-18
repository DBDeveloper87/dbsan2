class VideosController < ApplicationController
	before_action :authenticate_user!, only: [:index, :new, :edit, :create, :update]
	layout "application", only: [:index, :show]

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

		

end
