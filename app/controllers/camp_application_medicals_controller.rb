class CampApplicationMedicalsController < ApplicationController
	before_action :authenticate_user!
	before_action :get_application, only: [:new, :create]
	before_action :set_medical, only: [:edit, :update]

	def new
		@medical = @application.build_camp_application_medical
	end

	def edit
	end

	def create
		@medical = @application.build_camp_application_medical(medical_params)

		respond_to do |format|
			if @medical.save
				format.html {redirect_to new_camp_camp_application_camp_application_emergency_path(@camp, @application)}
			else
				render :new
			end
		end
	end

	def update
		respond_to do |format|
			if @medical.update(medical_params)
				if !@application.camp_application_emergency.nil?
					format.html {redirect_to new_camp_camp_application_camp_application_emergency_path(@camp, @application, @application.camp_application_emergency)}
				elsif @application.camp_application_emergency.nil?
					format.html {redirect_to new_camp_camp_application_camp_application_emergency_path(@camp, @application)}
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

		def set_medical
			@medical = CampApplicationMedical.find(params[:id])
			@application = @medical.camp_application
			@camp = @application.camp
		end

		def medical_params
			params.require(:camp_application_medical).permit(:other_health)
		end
end
