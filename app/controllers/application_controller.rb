class ApplicationController < ActionController::Base
	#require 'net/https'
	before_action :set_social
	#before_action :ensure_subdomain
	helper_method :admin?
	helper_method :current_channel

	def admin?
		current_user&.admin == true
	end

	def require_admin
  		unless current_user&.admin == true
  			redirect_to root_path, notice: "Sorry, you are not aurthoized to be in that spot!"
  		end
  	end

	def default_meta_tags
		@meta_title = "DBSAN"
		@meta_og_type = nil
		@meta_og_url = nil
		@meta_og_image = nil
	end

	def set_social
		subdomain = Subdomain.find_by(slug: request.subdomain)
		channels = Channel.all
		domains = []
		channels.each do |c|
			domains.append(c.domain_host)
		end
		domains = domains.uniq

		if request.domain == "dbsan.org" or request.domain == "example.com"
			if request.subdomain == "surveys"
				channel = Channel.find_by(domain_host: "dbsan.org")
			else
				channel = subdomain.channel
			end
		elsif request.domain.in?(domains)
			channel = Channel.find_by(domain_host: request.domain)
		end
		@networks = channel.social_networks.all
	end	
	
	def current_channel
		subdomain = Subdomain.find_by(slug: request.subdomain)
		@current_channel = subdomain.channel
	end

	private
		def ensure_subdomain
			redirect_to root_url(subdomain: :www) unless current_channel.present?
		end

end
