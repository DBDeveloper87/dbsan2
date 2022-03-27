class CampApplicationPisController < ApplicationController
	before_action :authenticate_user!
	before_action :get_application, only: [:new, :create]
	before_action :set_pi, only: [:edit, :update]

	def new
		@pi = @application.build_camp_application_pi
	end

	def edit
	end

	def create
		@pi = @application.build_camp_application_pi(pi_params)

		respond_to do |format|
			if @pi.save
				format.html {redirect_to new_camp_camp_application_camp_application_bi_path(@camp, @application)}
			else
				render :new
			end
		end
	end

	def update
		respond_to do |format|
			if @pi.update(pi_params)
				if !@application.camp_application_bi.nil?
					format.html {redirect_to edit_camp_camp_application_camp_application_bi_path(@camp, @application, @application.camp_application_bi)}
				elsif @application.camp_application_bi.nil?
					format.html {redirect_to new_camp_camp_application_camp_application_bi_path(@camp, @application)}
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

		def set_pi
			@pi = CampApplicationPi.find(params[:id])
			@application = @pi.camp_application
			@camp = @application.camp
		end

		def pi_params
			params.require(:camp_application_pi).permit(:first_name, :last_name)
		end
end
