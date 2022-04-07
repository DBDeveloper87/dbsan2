class CampApplicationTrainingsController < ApplicationController
	before_action :authenticate_user!
	before_action :get_application, only: [:new, :create]
	before_action :set_training, only: [:edit, :update]

	def new
		if !@application.camp_application_training.nil?
			redirect_to edit_camp_camp_application_camp_application_training_path(@camp, @application, @application.camp_application_training)
		else
			@training = @application.build_camp_application_training
		end
	end

	def edit
	end
	
	def create
		@training = @application.build_camp_application_training(training_params)

		respond_to do |format|
			if @training.save
				format.html {redirect_to new_camp_camp_application_camp_application_ca_path(@camp, @application) }
			else
				render :new
			end
		end
	end

	def update
		respond_to do |format|
			if @training.update(training_params)
				format.html {redirect_to new_camp_camp_application_camp_application_ca_path(@camp, @application) }
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

		def set_training
			@training = CampApplicationTraining.find(params[:id])
			@application = @training.camp_application
			@camp = @application.camp
		end

		def training_params
			params.require(:camp_application_training).permit(:available, training_history: [])
		end

end
