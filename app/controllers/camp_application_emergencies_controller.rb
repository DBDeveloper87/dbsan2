class CampApplicationEmergenciesController < ApplicationController
	before_action :authenticate_user!
	before_action :get_application, only: [:new, :create]
	before_action :set_emergency, only: [:edit, :update]

	def new
		if !@application.camp_application_emergency.nil?
			redirect_to edit_camp_camp_application_camp_application_emergency_path(@camp, @application, @application.camp_application_emergency)
		else
			@contact = @application.build_camp_application_emergency
		end
	end

	def edit
	end

	def create
		@contact = @application.build_camp_application_emergency(emergency_params)

		respond_to do |format|
			if @contact.save
				format.html {redirect_to camp_camp_application_next_steps_path(@camp, @application)}
			else
				render :new
			end
		end
	end

	def update
		respond_to do |format|
			if @contact.update(emergency_params)
				format.html {redirect_to camp_camp_application_next_steps_path(@camp, @application)}
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
			params.require(:camp_application_emergency).permit(:contact_full_name, :contact_relationship)
		end
end
