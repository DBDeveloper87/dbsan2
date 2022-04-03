class CampApplicationLodgingsController < ApplicationController
	before_action :authenticate_user!
	before_action :get_application, only: [:new, :create]
	before_action :set_lodging, only: [:edit, :update]

	def new
		if !@application.camp_application_lodging.nil?
			redirect_to edit_camp_camp_application_camp_application_lodging_path(@camp, @application, @application.camp_application_lodging)
		else
			@lodging = @application.build_camp_application_lodging
		end
	end

	def edit
	end

	def create
		@lodging = @application.build_camp_application_lodging(lodging_params)

		respond_to do |format|
			if @lodging.save
				format.html {redirect_to new_camp_camp_application_camp_application_meal_path(@camp, @application) }
			else
				render :new
			end
		end
	end

	def update
		respond_to do |format|
			if @lodging.update(lodging_params)
				format.html {redirect_to new_camp_camp_application_camp_application_meal_path(@camp, @application) }
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

		def set_lodging
			@lodging = CampApplicationLodging.find(params[:id])
			@application = @lodging.camp_application
			@camp = @application.camp
		end

		def lodging_params
			params.require(:camp_application_lodging).permit(:difficulty_stairs, :difficulty_walking, :medical_device_charging, :mobility_aids, :on_premises, :service_animal, :share_service_animal, :share_smoker)
		end
end
