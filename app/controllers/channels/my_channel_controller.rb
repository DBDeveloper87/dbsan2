class Channels::MyChannelController < ApplicationController
	before_action :set_channel, only: [:show, :edit, :update]
	before_action :render_home, only: :show
	before_action :camps, only: :show
	
	def edit
	end

	def show
		if @channel.name == "ILY by Tricio"
			@meta_mg_image = "https://storage.googleapis.com/dbsan-public/ILY%20by%20Tricio.png"
			@meta_title = @channel.name
		end
		
		
	end

	def update
		if @channel.update(channel_params)
			redirect_to channel_root_path
		end
	end

	private
		def camps
			@camps = Camp.all
		end

		def channel_params
			params.require(:channel).permit(:name, :brand_logo)
		end

		def set_channel
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
			@meta_title = @channel.name
		end

		def render_home
			if @channel.name == "DeafBlind Support and Access Network"
				render layout: "application"
			else
				render layout: "channel"
			end
		end

			
end
