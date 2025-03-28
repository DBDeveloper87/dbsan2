class VideosController < ApplicationController
	before_action :authenticate_user!, only: [:index, :new, :edit, :create, :update]
	before_action :get_channel
	before_action :set_video, only: [:show, :edit, :update]
	before_action :set_video_id, only: [:ad_menu, :playback_rate]
	layout "channel", only: [:show]

	def index
		@videos = @channel.videos.all
	end

	def new
		@upload = Upload.new	
	end

	def edit
		@video = Video.find(params[:id])
	end

	def show
	end

	def ad_menu
		render template: "videos/controls/settings_menu/ad_menu"
	end

	def playback_rate
		render template: "videos/controls/settings_menu/playback_rate"
	end

	def create
		@video = @channel.videos.create(video_params)

		if @video.save
			redirect_to video_path(@video)
		end
	end

	def update
		if @video.update(video_params)
			respond_to do |f|
				@videos = @channel.videos.all
				f.turbo_stream
			end
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

		def set_video
			@video = @channel.videos.find(params[:id])
			@meta_title = "#{@video.title} | #{@video.channel.name}"
			@meta_og_type = "video.movie"
			@meta_og_url = video_url(@video)
			#@meta_og_image = "https://storage.googleapis.com/dbsan-public/poster.png"
		end

		def set_video_id
			@video = @channel.videos.find(params[:video_id])
			@meta_title = "#{@video.title} | #{@video.channel.name}"
			@meta_og_type = "video.movie"
			@meta_og_url = video_url(@video)
			#@meta_og_image = "https://storage.googleapis.com/dbsan-public/poster.png"
		end
		

		

end
