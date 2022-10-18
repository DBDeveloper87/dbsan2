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
		@networks = SocialNetwork.all
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
