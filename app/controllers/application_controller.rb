class ApplicationController < ActionController::Base
	#before_action :authenticate_user!
	before_action :set_social
	
	def default_meta_tags
		@meta_title = "DBSAN"
	end

	def set_social
		@networks = SocialNetwork.all
	end
	
	
	def after_sign_in_path_for(resource)
		edit_user_registration_path(current_user)
	end
end
