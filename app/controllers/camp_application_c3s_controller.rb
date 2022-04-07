class CampApplicationC3sController < ApplicationController
	before_action :authenticate_user!
	before_action :get_application, only: [:new, :create]
	before_action :set_c3, only: [:edit, :update]

	def new
		if !@application.camp_application_c3.nil?
			redirect_to edit_camp_camp_application_camp_application_c3_path(@camp, @application, @application.camp_application_c3)
		else
			@c3 = @application.build_camp_application_c3
		end
		
	end

	def edit
	end

	def create
		@c3 = @application.build_camp_application_c3(c3_params)

		respond_to do |format|
			if @c3.save and !@c3.agree?
				format.html {redirect_to camp_camp_application_c3_error_path(@camp, @application)}
			elsif @c3.save and @c3.agree?
				format.html {redirect_to new_camp_camp_application_camp_application_permission_path(@camp, @application)}
			elsif @c3.save
				format.html {redirect_to new_camp_camp_application_camp_application_permission_path(@camp, @application)}
			else
				render :new
			end
		end
	end

	def update
		respond_to do |format|
			if @c3.update(c3_params) and !@c3.agree?
				format.html {redirect_to camp_camp_application_c3_error_path(@camp, @application)}
			elsif @c3.update(c3_params) and @c3.agree?
				format.html {redirect_to new_camp_camp_application_camp_application_permission_path(@camp, @application)}
			elsif @c3.update(c3_params)
				format.html {redirect_to new_camp_camp_application_camp_application_permission_path(@camp, @application)}
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

		def set_c3
			@c3 = CampApplicationC3.find(params[:id])
			@application = @c3.camp_application
			@camp = @application.camp
		end

		def c3_params
			params.require(:camp_application_c3).permit(:agree)
		end
end
