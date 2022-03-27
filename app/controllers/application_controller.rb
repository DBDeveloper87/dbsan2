class ApplicationController < ActionController::Base
	#before_action :authenticate_user!
	before_action :set_social
	
	def default_meta_tags
		@meta_title = "DBSAN"
	end

	def set_social
		@networks = SocialNetwork.all
	end
	
	
	
end
