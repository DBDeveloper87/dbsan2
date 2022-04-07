class CampApplicationCasController < ApplicationController
	before_action :authenticate_user!
	before_action :get_application, only: [:new, :create]
	before_action :set_ca, only: [:edit, :update]

	def new
		if !@application.camp_application_ca.nil?
			redirect_to edit_camp_camp_application_camp_application_ca_path(@camp, @application, @application.camp_application_ca)
		else
			@ca = @application.build_camp_application_ca
		end
	end

	def edit
	end
	
	def create
		@ca = @application.build_camp_application_ca(ca_params)

		respond_to do |format|
			if @ca.save
				format.html {redirect_to new_camp_camp_application_camp_application_shift_path(@camp, @application) }
			else
				render :new
			end
		end
	end

	def update
		respond_to do |format|
			if @ca.update(ca_params)
				format.html {redirect_to new_camp_camp_application_camp_application_shift_path(@camp, @application) }
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

		def set_ca
			@ca = CampApplicationCa.find(params[:id])
			@application = @ca.camp_application
			@camp = @application.camp
		end

		def ca_params
			params.require(:camp_application_ca).permit(:pt, :tactile, :sign_language)
		end

end
