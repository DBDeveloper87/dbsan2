class CampApplicationMealsController < ApplicationController
	before_action :authenticate_user!
	before_action :get_application, only: [:new, :create]
	before_action :set_meal, only: [:edit, :update]

	def new
		@meal = @application.build_camp_application_meal
	end

	def edit
	end

	def create
		@meal = @application.build_camp_application_meal(meal_params)

		respond_to do |format|
			if @meal.save
				format.html {redirect_to new_camp_camp_application_camp_application_medical_path(@camp, @application) }
			else
				render :new
			end
		end
	end

	def update
		respond_to do |format|
			if @meal.update(meal_params)
				format.html {redirect_to new_camp_camp_application_camp_application_medical_path(@camp, @application) }
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

		def set_meal
			@meal = CampApplicationMeal.find(params[:id])
			@application = @meal.camp_application
			@camp = @application.camp
		end

		def meal_params
			params.require(:camp_application_meal).permit(:dietary_lifestyle)
		end


end
