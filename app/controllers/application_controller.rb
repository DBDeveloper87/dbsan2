class ApplicationController < ActionController::Base
	#before_action :authenticate_user!
	before_action :set_social
	helper_method :admin?
	
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
	end

	def set_social
		@networks = SocialNetwork.all
	end
	
	
	
end
