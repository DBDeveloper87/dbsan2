class VideosController < ApplicationController
	before_action :authenticate_user!, only: [:index, :new, :edit, :create, :update]
	before_action :get_channel
	layout "channel", only: [:index, :show]

	def index
		@subdomain = Subdomain.find_by(slug: request.subdomain)
		@channel = @subdomain.channel
		@videos = @channel.videos.all
	end

	def new
		@video = @channel.videos.build	
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
		@video = @channel.videos.create(video_params)

		if @video.save
			redirect_to video_path(@video)
		end
	end

	private
		def video_params
			params.require(:video).permit(:title, :original_upload)
		end	

		def get_channel
			@subdomain = Subdomain.find_by(slug: request.subdomain)
			@channels = Channel.all
			domains = []
			@channels.each do |c|
				domains.append(c.domain_host)
			end
			domains = domains.uniq

			if request.domain == "dbsan.org" or request.domain == "example.com"
				@channel = @subdomain.channel
			elsif request.domain.in?(domains)
				@channel = Channel.find_by(domain_host: request.domain)
			end
			@meta_title = "Videos | #{@channel.name}"
		end
		

		

end
