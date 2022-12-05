class PortfoliosController < ApplicationController
	before_action :get_channel, only: [:index, :show]
	before_action :set_portfolio, only: :show
	layout "channel"

	def index
		redirect_to portfolio_path(@channel)
	end

	def show
	end

	private
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

		def set_portfolio
			@portfolio = @channel.portfolio
			@meta_title = "Portfolio | #{@channel.name}"
			#@meta_og_type = "video.movie"
			#@meta_og_url = video_url(@video)
			#@meta_og_image = "https://storage.googleapis.com/dbsan-public/poster.png"
		end
end
