class CampApplicationBisController < ApplicationController
	before_action :authenticate_user!
	before_action :get_application, only: [:new, :create]
	before_action :set_bi, only: [:edit, :update]

	def new
		@bi = @application.build_camp_application_bi
	end

	def create
		@bi = @application.build_camp_application_bi(bi_params)

		respond_to do |format|
			if @bi.save
				id = @application.id
				format.html {redirect_to new_camp_camp_application_camp_application_inc_path(@camp, @application) }
			else
				render :new
			end
		end
	end

	def update
		respond_to do |format|
			if @bi.update(bi_params)
				if !@application.camp_application_inc.nil?
					format.html {redirect_to edit_camp_camp_application_camp_application_inc_path(@camp, @application, @application.camp_application_inc) }
				elsif @application.camp_application_inc.nil?
					format.html {redirect_to new_camp_camp_application_camp_application_inc_path(@camp, @application) }
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
		end

		def set_bi
			@bi = CampApplicationBi.find(params[:id])
			@application = @bi.camp_application
			@camp = @application.camp
		end

		def bi_params
			params.require(:camp_application_bi).permit(:active_community, :other_comments, interests: [])
		end
end
