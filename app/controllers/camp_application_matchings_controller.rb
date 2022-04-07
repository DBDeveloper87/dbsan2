class CampApplicationMatchingsController < ApplicationController
	before_action :authenticate_user!
	before_action :get_application, only: [:new, :create]
	before_action :set_matching, only: [:edit, :update]

	def new
		if !@application.camp_application_matching.nil?
			redirect_to edit_camp_camp_application_camp_application_matching_path(@camp, @application, @application.camp_application_matching)
		else
			@match = @application.build_camp_application_matching
		end
	end

	def edit
	end

	def create
		@match = @application.build_camp_application_matching(matching_params)

		respond_to do |format|
			if @match.save
				if @application.camp_application_type.kind == "Volunteer"
					format.html { redirect_to new_camp_camp_application_camp_application_ceu_path(@camp, @application) }
				elsif @application.camp_application_type.kind == "Participant"
					format.html {redirect_to new_camp_camp_application_camp_application_lodging_path(@camp, @application) }
				end
			else
				render :new
			end
		end
	end

	def update
		respond_to do |format|
			if @match.update(matching_params)
				if @application.camp_application_type.kind == "Volunteer"
					format.html { redirect_to new_camp_camp_application_camp_application_ceu_path(@camp, @application) }
				elsif @application.camp_application_type.kind == "Participant"
					format.html {redirect_to new_camp_camp_application_camp_application_lodging_path(@camp, @application) }
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
			@app_type = @application.camp_application_type.kind.downcase
			@camp_app_types = @camp.camp_application_types
		end

		def set_matching
			@match = CampApplicationMatching.find(params[:id])
			@application = @match.camp_application
			@camp = @application.camp
			@app_type = @application.camp_application_type.kind.downcase
			@camp_app_types = @camp.camp_application_types
		end

		def matching_params
			params.require(:camp_application_matching).permit(
				:describe_self,
				:height,
				activity_type: [],
				work_with_type: [],
				camp_application_matchnps_attributes: [
					:id, :_destroy, :first_name, :last_name, :name_type
					]
				)
		end		
end
