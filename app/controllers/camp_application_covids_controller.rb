class CampApplicationCovidsController < ApplicationController
	before_action :authenticate_user!
	before_action :get_application, only: [:new, :create]
	before_action :set_covid, only: [:edit, :update]

	def new
		if !@application.camp_application_covid.nil?
			redirect_to edit_camp_camp_application_camp_application_covid_path(@camp, @application, @application.camp_application_covid)
		else
			@covid = @application.build_camp_application_covid
		end
	end

	def edit
	end

	def create
		@covid = @application.build_camp_application_covid(covid_params)

		respond_to do |format|
			if @covid.save and !@covid.vaccinated?
				format.html {redirect_to camp_camp_application_covid_error_path(@camp, @application)}
			elsif @covid and @covid.vaccinated?
				format.html { redirect_to new_camp_camp_application_camp_application_pi_path(@camp, @application) }
			elsif @covid.save
				format.html { redirect_to new_camp_camp_application_camp_application_pi_path(@camp, @application) }
			else
				render :new
			end
		end
	end

	def update
		respond_to do |format|
			if @covid.update(covid_params) and !@covid.vaccinated?
				format.html {redirect_to camp_camp_application_covid_error_path(@camp, @application)}
			elsif @covid.update(covid_params) and @covid.vaccinated?
				format.html { redirect_to new_camp_camp_application_camp_application_pi_path(@camp, @application) }
			elsif covid.update(covid_params)
				format.html { redirect_to new_camp_camp_application_camp_application_pi_path(@camp, @application) }
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
			params.require(:camp_application_covid).permit(:vaccinated, :first_shot, :second_shot, :booster_shot, vaccination_type: [])
		end
end
