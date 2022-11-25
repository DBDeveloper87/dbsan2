class Channels::MyChannelController < ApplicationController
	before_action :set_channel, only: [:show, :edit, :update]
	before_action :render_home, only: :show

	def edit
	end

	def show
		@meta_title = @channel.name
		if @channel.name == "ILY by Tricio"
			@meta_mg_image = "https://storage.googleapis.com/dbsan-public/ILY%20by%20Tricio.png"
		end
		@camps = Camps.all
	end

	def update
		if @channel.update(channel_params)
			redirect_to channel_root_path
		end
	end

	private
		def channel_params
			params.require(:channel).permit(:name, :brand_logo)
		end

		def set_channel
			@subdomain = Subdomain.find_by(slug: request.subdomain)
			@channel = @subdomain.channel
		end

		def render_home
			if @channel.name == "DeafBlind Support and Access Network"
				render layout: "application"
			else
				render layout: "channel"
			end
		end

			
end
