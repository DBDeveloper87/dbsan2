class Channels::MyChannelController < ApplicationController
	before_action :subdomain

	def index
	end

	private
		def subdomain
			@subdomain = Subdomain.find_by(slug: request.subdomain)
		end
end
