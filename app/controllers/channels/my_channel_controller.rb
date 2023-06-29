class Channels::MyChannelController < ApplicationController
	before_action :authenticate_user!, only: [:edit, :update]
	before_action :set_channel, only: [:show, :edit, :update, :special_event]
	before_action :require_owner_or_channel_admin, only: [:edit, :update]
	before_action :render_home, only: [:show, :special_event]
	before_action :camps, only: :show
	

	def edit
	end

	def show
		if @channel.name == "ILY by Tricio"
			@meta_mg_image = "https://storage.googleapis.com/dbsan-public/ILY%20by%20Tricio.png"
			@meta_title = @channel.name
		end	
	end

	def special_event
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
		def require_owner_or_channel_admin
			channel_admins = []
			unless @channel.members.empty?
				@channel.members.each do |m|
					if m.channel_admin?
						channel_admins.append(m.user.id)
					end
				end
			end

			if @channel.owner.present?
				unless @channel.owner.user.id == current_user&.id or channel_admins.include?(current_user&.id)
					redirect_to root_path
				end
			else
				unless channel_admins.include?(current_user&.id)
					redirect_to root_path
				end
			end
		end

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
