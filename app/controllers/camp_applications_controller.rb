class CampApplicationsController < ApplicationController
	before_action :authenticate_user!
	before_action :get_camp, only: [:new, :create, :index]
	before_action :get_application, only: [:next_steps]
	before_action :set_application, only: [:edit, :update, :show]

	def index
		if params[:filter] == "all"
			@apps = @camp.camp_applications.all
		end
	end

	def new
		@application = @camp.camp_applications.build
		@camp.camp_applications.each do |app|
			if app.user_id == current_user.id and app.status == "Submitted"
				redirect_to camp_camp_application_path(@camp, app.id)
			elsif app.user_id == current_user.id
				redirect_to edit_camp_camp_application_path(@camp, app.id)
			end
		end
	end

	def edit	
	end

	def show
	end

	def success
		@application = CampApplication.find(params[:camp_application_id])
	end

	def next_steps
		@application = CampApplication.find(params[:camp_application_id])
	end

	def c3_error
		@application = CampApplication.find(params[:camp_application_id])
	end

	def covid_error
		@application = CampApplication.find(params[:camp_application_id])
	end

	def submit_application
		@application = CampApplication.find(params[:camp_application_id])
		@application.status = "Submitted"

		respond_to do |format|
			if @application.save
				CampApplicationMailer.with(camp_application: @application).submission_notification.deliver_now
				CampApplicationMailer.with(camp_application: @application).submission_receipt.deliver_now
				format.html { redirect_to camp_camp_application_success_path(@application.camp, @application) }
			end
		end
	end

	def create
		@application = @camp.camp_applications.create(application_params)

		respond_to do |format|
      		if @application.save
      			CampApplicationMailer.with(camp_application: @application).application_started.deliver_now
      			format.html {redirect_to new_camp_camp_application_camp_application_c3_path(@camp, @application) }
        	else
        		format.html { render :new }
        	end
    	end
	end

	def update
		respond_to do |format|
			if @application.update(application_params)
				format.html { redirect_to new_camp_camp_application_camp_application_c3_path(@camp, @application) }
      			
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
