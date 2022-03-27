class CampApplicationCovidsController < ApplicationController
	before_action :authenticate_user!
	before_action :get_application, only: [:new, :create]
	before_action :set_covid, only: [:edit, :update]

	def new
		@covid = @application.build_camp_application_covid
	end

	def edit
	end

	def create
		@covid = @application.build_camp_application_covid(covid_params)

		respond_to do |format|
			if @covid.save
				format.html {redirect_to camp_camp_application_next_steps_path(@camp, @application)}
			else
				render :new
			end
		end
	end

	def update
		respond_to do |format|
			if @covid.update(covid_params)
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

		def set_covid
			@covid = CampApplicationCovid.find(params[:id])
			@application = @covid.camp_application
			@camp = @application.camp
		end

		def covid_params
			params.require(:camp_application_covid).permit(:vaccinated)
		end
end
