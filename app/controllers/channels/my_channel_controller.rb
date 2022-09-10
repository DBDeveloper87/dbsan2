class Channels::MyChannelController < ApplicationController
	before_action :sub_request?

	def show
	end

	private
		def sub_request?
			if request.subdomain.present?
				set_channel
			end
		end

		def set_channel
			subdomain = Subdomain.find_by(slug: request.subdomain)
			@channel = Channel.find_by(subdomain_id: subdomain.id)
		end
end
