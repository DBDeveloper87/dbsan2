class Channels::MyChannelController < ApplicationController
	before_action :set_channel, only: [:show, :edit, :update]
	layout "channel"

	def edit
	end

	def show
		
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
end
