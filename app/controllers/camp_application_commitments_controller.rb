class CampApplicationCommitmentsController < ApplicationController
	before_action :authenticate_user!
	before_action :get_application, only: [:new, :create]
	before_action :set_commitment, only: [:edit, :update]

	def new
		if !@application.camp_application_commitment.nil?
			redirect_to edit_camp_camp_application_camp_application_commitment_path(@camp, @application, @application.camp_application_commitment)
		else
			@commitment = @application.build_camp_application_commitment
		end
	end

	def edit
	end
	
	def create
		@commitment = @application.build_camp_application_commitment(commitment_params)

		respond_to do |format|
			if @commitment.save
				format.html {redirect_to new_camp_camp_application_camp_application_lodging_path(@camp, @application) }
			else
				render :new
			end
		end
	end

	def update
		respond_to do |format|
			if @commitment.update(commitment_params)
				format.html {redirect_to new_camp_camp_application_camp_application_lodging_path(@camp, @application) }
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

		def set_commitment
			@commitment = CampApplicationCommitment.find(params[:id])
			@application = @commitment.camp_application
			@camp = @application.camp
		end

		def commitment_params
			params.require(:camp_application_commitment).permit(:commit)
		end

end