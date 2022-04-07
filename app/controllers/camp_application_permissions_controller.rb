class CampApplicationPermissionsController < ApplicationController
	before_action :authenticate_user!
	before_action :get_application, only: [:new, :create]
	before_action :set_permission, only: [:edit, :update]

	def new
		if !@application.camp_application_permission.nil?
			redirect_to edit_camp_camp_application_camp_application_permission_path(@camp, @application, @application.camp_application_permission)
		else
			@permission = @application.build_camp_application_permission
		end
	end

	def edit
	end

	def create
		@permission = @application.build_camp_application_permission(permission_params)

		respond_to do |format|
			if @permission.save
				format.html {redirect_to new_camp_camp_application_camp_application_covid_path(@camp, @application)}
			else
				render :new
			end
		end
	end

	def update
		respond_to do |format|
			if @permission.update(permission_params)
				format.html {redirect_to new_camp_camp_application_camp_application_covid_path(@camp, @application)}
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

		def set_permission
			@permission = CampApplicationPermission.find(params[:id])
			@application = @permission.camp_application
			@camp = @application.camp
		end

		def permission_params
			params.require(:camp_application_permission).permit(:agree)
		end
end
