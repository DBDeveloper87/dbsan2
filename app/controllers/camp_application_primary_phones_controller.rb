class CampApplicationPrimaryPhonesController < ApplicationController
	before_action :get_application, only: [:new, :create]

	def new
		@phone = PhoneNumber.new
	end

	def create
		@phone = PhoneNumber.create(phone_params)
		
		respond_to do |format|
			if @phone.save
				format.html {redirect_to new_camp_camp_application_camp_application_bi_path(@camp, @application)}
			else
				render :new
			end
		end
	end

	private
		def get_application
			@application = CampApplication.find(params[:camp_application_id])
			@camp = @application.camp
		end

		def phone_params
			params.permit(:user_id, :camp_application_pi_id, :phone_number, :phone_type, service_type: [])
		end
end
