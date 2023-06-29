class Channels::MembersController < ApplicationController
	before_action :authenticate_user!
	before_action :set_channel, only: [:index, :new, :create]
	before_action :require_owner_or_channel_admin

	def index
		@meta_title = "Members | #{@channel.name}"
		@members = @channel.members.all.sort { |a, b| a.last_name <=> b.last_name}
	end

	def new
		@meta_title = "New Member | #{@channel.name}"
		@member = @channel.members.build
	end

	def create
		@member = @channel.members.create(create_params)

		if @member.save
			redirect_to members_path
		else
			render :new, status: :unprocessable_entity
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

		def create_params
			params.require(:channel_member).permit(:user_id)
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
end
