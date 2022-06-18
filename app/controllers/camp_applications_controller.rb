class CampApplicationsController < ApplicationController
	before_action :authenticate_user!
	before_action :get_camp, only: [:new, :create, :index, :contact_info_report, :meal_summary_report]
	before_action :get_application, only: [:next_steps]
	before_action :set_application, only: [:edit, :update, :show]
	before_action :require_admin, only: [:index, :show]

	def index
		if params[:filter] == "all"
			@apps = @camp.camp_applications.all
		elsif params[:filter] == 'volunteers'
			@all = @camp.camp_applications.all
			@apps = []
			@all.each do |app|
				if app.camp_application_type.kind == "Volunteer"
					@apps.append(app)
				end
			end
		elsif params[:filter] == 'participants'
			@all = @camp.camp_applications.all
			@apps = []
			@all.each do |app|
				if app.camp_application_type.kind == "Volunteer"
					@apps.append(app)
				end
			end
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
		@user_name = @application.user.profile.first_name + " " + @application.user.profile.last_name
		@user_email = @application.user.email
		@confirmed = @application.user.confirmed_at
		@status = @application.status
		@pi = @application.camp_application_pi
		@c3 = @application.camp_application_c3
		@permission = @application.camp_application_permission
		@covid = @application.camp_application_covid
		unless @pi.nil?
			@aug_15 = ((Date.parse("Aug 15 2022") - @pi.dob) / 365).round
		end
		@bi = @application.camp_application_bi
		@inc = @application.camp_application_inc
		@matching = @application.camp_application_matching
		@type = @application.camp_application_type
		@ceu = @application.camp_application_ceu
		@training = @application.camp_application_training
		@ca = @application.camp_application_ca
		@shift = @application.camp_application_shift
		@commitment = @application.camp_application_commitment
		@lodging = @application.camp_application_lodging
		@meal = @application.camp_application_meal
		@medical = @application.camp_application_medical
	end

	def contact_info_report
		@apps = @camp.camp_applications.all
		
	end

	def meal_summary_report
		@apps = @camp.camp_applications.all
		
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
