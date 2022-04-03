class CampApplicationPisController < ApplicationController
	before_action :authenticate_user!
	before_action :get_application, only: [:new, :create]
	before_action :set_pi, only: [:edit, :update]

	def phone_number
		@application = CampApplication.find(params[:camp_application_id])
		@camp = @application.camp
		@pi = @application.camp_application_pi
		@phone = @pi.build_phone_number

		#render partial: "phone_number"	
	end

	def create_phone
		@application = CampApplication.find(params[:camp_application_id])
		@camp = @application.camp
		@pi = @application.camp_application_pi
		@phone = @pi.build_phone_number(phone_params)
		respond_to do |format|
			if @phone.save
				format.html {redirect_to root_path}
			else
				redirect_to camps_path
			end
		end
	end	

	def new
		if !@application.camp_application_pi.nil?
			redirect_to edit_camp_camp_application_camp_application_pi_path(@camp, @application, @application.camp_application_pi)
		else
			@pi = @application.build_camp_application_pi 
		end
	end

	def edit		
	end

	def create
		@pi = @application.build_camp_application_pi(pi_params)
		@phone = @pi.build_phone_number(phone_params)

		respond_to do |format|
			if @pi.save
				format.html {redirect_to camp_camp_application_camp_application_pi_phone_path(@camp, @application)}
			else
				render :new
			end

			
		end

		
	end

	def update
		respond_to do |format|
			if @pi.update(pi_params)
				format.html {redirect_to camp_camp_application_camp_application_pi_phone_path(@camp, @application, @application.camp_application_pi)}
				#if !@application.camp_application_bi.nil?
				#	format.html {redirect_to edit_camp_camp_application_camp_application_bi_path(@camp, @application, @application.camp_application_bi)}
				#elsif @application.camp_application_bi.nil?
				#	format.html {redirect_to new_camp_camp_application_camp_application_bi_path(@camp, @application)}
				#end
			else
				render :edit
			end
		end
	end

	private
		def get_application
			@application = CampApplication.find(params[:camp_application_id])
			@camp = @application.camp
			@states = []
			@counties = []
		end

		def set_pi
			@pi = CampApplicationPi.find(params[:id])
			@application = @pi.camp_application
			@camp = @application.camp
			@states = []
			@counties = []
		end

		def phone_params
			params.require(:phone_number).permit(:camp_application_pi_id, :phone_number)
		end

		def pi_params
			params.require(:camp_application_pi).permit(:first_name, :last_name, :dob,
				:phone_number_attributes => [:phone_number],
				gender: [],
				pronouns: [],
				address_attributes: [
					:address_type, :address_l1, :address_l2,
					:city, :state_province_id, :county_id, :zippostal, :zip4code, :profile_id],
				)
		end
	end