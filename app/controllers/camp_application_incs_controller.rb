class CampApplicationIncsController < ApplicationController
	before_action :authenticate_user!
	before_action :get_application, only: [:new, :create]
	before_action :set_inc, only: [:edit, :update]

	def new
		if !@application.camp_application_inc.nil?
			redirect_to edit_camp_camp_application_camp_application_inc_path(@camp, @application, @application.camp_application_inc)
		else
			@inc = @application.build_camp_application_inc
		end
	end

	def edit
	end

	def create
		@inc = @application.build_camp_application_inc(inc_params)

		respond_to do |format|
			if @inc.save
				format.html {redirect_to new_camp_camp_application_camp_application_matching_path(@camp, @application) }
			else
				render :new
			end
		end
	end

	def update
		respond_to do |format|
			if @inc.update(inc_params)
				format.html {redirect_to new_camp_camp_application_camp_application_matching_path(@camp, @application) }
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

		def set_inc
			@inc = CampApplicationInc.find(params[:id])
			@application = @inc.camp_application
			@camp = @application.camp
		end

		def inc_params
			params.require(:camp_application_inc).permit(:dominant_hand, :receiv_signs, communication_pref: [], identity: [])
		end
end
