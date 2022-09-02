class Channels::MyChannelController < ApplicationController
	before_action :set_channel, only: :show

	def show
	end

	private
		def set_channel
			@channel = Channel.find_by(slug: request.subdomain)
		end
end
