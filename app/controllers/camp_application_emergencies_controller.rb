class CampApplicationEmergenciesController < ApplicationController
	before_action :authenticate_user!
	before_action :get_application, only: [:new, :create]
	before_action :set_emergency, only: [:edit, :update]

	def new
		@contact = @application.build_camp_application_emergency
	end

	def edit
	end

	def create
		@contact = @application.build_camp_application_emergency(emergency_params)

		respond_to do |format|
			if @contact.save
				format.html {redirect_to new_camp_camp_application_camp_application_c3_path(@camp, @application)}
			else
				render :new
			end
		end
	end

	def update
		respond_to do |format|
			if @contact.update(emergency_params)
				if !@application.camp_application_c3.nil?
					format.html {redirect_to new_camp_camp_application_camp_application_c3_path(@camp, @application, @application.camp_application_c3)}
				elsif @application.camp_application_c3.nil? 
					format.html {redirect_to new_camp_camp_application_camp_application_c3_path(@camp, @application)}
				end
			else
				render :edit
			end
		end
	end

	private
		def get_application
			@application = CampApplication.find(params[:camp_application_id])
			@camp = @application.camp
		end

		def set_emergency
			@contact = CampApplicationEmergency.find(params[:id])
			@application = @contact.camp_application
			@camp = @application.camp
		end

		def emergency_params
			params.require(:camp_application_emergency).permit(:contact_full_name)
		end
end
