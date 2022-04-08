class CampApplicationCeusController < ApplicationController
	before_action :authenticate_user!
	before_action :get_application, only: [:new, :create]
	before_action :set_ceu, only: [:edit, :update]

	def new
		if !@application.camp_application_ceu.nil?
			redirect_to edit_camp_camp_application_camp_application_ceu_path(@camp, @application, @application.camp_application_ceu)
		else
			@ceu = @application.build_camp_application_ceu
		end
	end

	def edit
	end

	def create
	end
	
	def create
		@ceu = @application.build_camp_application_ceu(ceu_params)

		respond_to do |format|
			if @ceu.save
				format.html {redirect_to new_camp_camp_application_camp_application_training_path(@camp, @application) }
			else
				render :new
			end
		end
	end

	def update
		respond_to do |format|
			if @ceu.update(ceu_params)
				format.html {redirect_to new_camp_camp_application_camp_application_training_path(@camp, @application) }
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

		def set_ceu
			@ceu = CampApplicationCeu.find(params[:id])
			@application = @ceu.camp_application
			@camp = @application.camp
		end

		def ceu_params
			params.require(:camp_application_ceu).permit(:certifications)
		end

end
