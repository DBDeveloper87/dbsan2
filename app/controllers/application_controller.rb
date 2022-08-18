class ApplicationController < ActionController::Base
	require 'net/https'
	before_action :set_social
	helper_method :admin?
	RECAPTCHA_MINIMUM_SCORE = 0.5
	

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
	
	def verify_recaptcha?(token, recaptcha_action)
    	secret_key = Rails.application.credentials.recaptcha[:SECRET_KEY]

    	uri = URI.parse("https://www.google.com/recaptcha/api/siteverify?secret=#{secret_key}&response=#{token}")
    	response = Net::HTTP.get_response(uri)
    	json = JSON.parse(response.body)
    	json['success'] && json['score'] > RECAPTCHA_MINIMUM_SCORE && json['action'] == recaptcha_action
    end	
end
