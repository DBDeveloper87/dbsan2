class CampApplicationsController < ApplicationController
	before_action :authenticate_user!
	before_action :get_camp, only: [:new, :create]
	before_action :get_application, only: [:next_steps]
	before_action :set_application, only: [:edit, :update]

	def index
	end

	def new
		@application = @camp.camp_applications.build
		@camp.camp_applications.each do |app|
			if app.user_id == current_user.id
				redirect_to edit_camp_camp_application_path(@camp, app.id)
			end
		end
	end

	def edit	
	end

	def next_steps
	end

	def create
		@application = @camp.camp_applications.create(application_params)

		respond_to do |format|
      		if @application.save
      			format.html {redirect_to new_camp_camp_application_camp_application_pi_path(@camp, @application) }
        	else
        		format.html { render :new }
        	end
    	end
	end

	def update
		respond_to do |format|
			if @application.update(application_params)
				if !@application.camp_application_pi.nil?
      				format.html { redirect_to edit_camp_camp_application_camp_application_pi_path(@camp, @application, @application.camp_application_pi) }
      			elsif @application.camp_application_pi.nil?
      				format.html { redirect_to new_camp_camp_application_camp_application_pi_path(@camp, @application) }
      			end
      		else
				render 'edit'
			end
		end
	end

	private
		def get_camp
			@camp = Camp.find(params[:camp_id])
		end

		def get_application
			@application = CampApplication.find(params[:camp_application_id])
			@camp = @application.camp
		end

		def set_application
			@application = CampApplication.find(params[:id])
			@camp = @application.camp
		end

		def application_params
			params.require(:camp_application).permit(:camp_id, :user_id, :camp_application_type_id)
		end

end
