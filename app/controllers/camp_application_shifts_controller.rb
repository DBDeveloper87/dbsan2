class CampApplicationShiftsController < ApplicationController
	before_action :authenticate_user!
	before_action :get_application, only: [:new, :create]
	before_action :set_shift, only: [:edit, :update]

	def new
		if !@application.camp_application_shift.nil?
			redirect_to edit_camp_camp_application_camp_application_shift_path(@camp, @application, @application.camp_application_shift)
		else
			@shift = @application.build_camp_application_shift
		end
	end

	def edit
	end
	
	def create
		@shift = @application.build_camp_application_shift(shift_params)

		respond_to do |format|
			if @shift.save
				format.html {redirect_to new_camp_camp_application_camp_application_commitment_path(@camp, @application) }
			else
				render :new
			end
		end
	end

	def update
		respond_to do |format|
			if @shift.update(shift_params)
				format.html {redirect_to new_camp_camp_application_camp_application_commitment_path(@camp, @application) }
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

		def set_shift
			@shift = CampApplicationShift.find(params[:id])
			@application = @shift.camp_application
			@camp = @application.camp
		end

		def shift_params
			params.require(:camp_application_shift).permit(shifts: [])
		end

end
