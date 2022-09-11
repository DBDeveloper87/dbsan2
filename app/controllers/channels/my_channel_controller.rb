class Channels::MyChannelController < ApplicationController
	before_action :set_channel, only: :show
	layout "channel"

	def show
	end

	private
		def set_channel
			@subdomain = Subdomain.find_by(slug: request.subdomain)
			@channel = @subdomain.channel
		end
end
