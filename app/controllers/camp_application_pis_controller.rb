class CampApplicationPisController < ApplicationController
	before_action :authenticate_user!
	before_action :get_application, only: [:new, :create]
	before_action :set_pi, only: [:edit, :update]

	def new
		if !@application.camp_application_pi.nil?
			redirect_to edit_camp_camp_application_camp_application_pi_path(@camp, @application, @application.camp_application_pi)
		else
			@pi = @application.build_camp_application_pi 
		end
	end

	def edit
		@phone = PhoneNumber.new		
	end

	def create
		@pi = @application.build_camp_application_pi(pi_params)
		
		respond_to do |format|
			if @pi.save
				format.html {redirect_to new_camp_camp_application_camp_application_bi_path(@camp, @application)}
			else
				render :new
			end

			
		end	
	end

	def update
		respond_to do |format|
			if @pi.update(pi_params)
				format.html {redirect_to new_camp_camp_application_camp_application_bi_path(@camp, @application)}
				
				
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

		def pi_params
			params.require(:camp_application_pi).permit(:first_name, :last_name, :dob,
				gender: [],
				pronouns: [],
				address_attributes: [
					:address_type, :address_l1, :address_l2,
					:city, :state_province_id, :county_id, :zippostal, :zip4code, :profile_id],
				phone_numbers_attributes: [:user_id, :camp_application_pi_id, :phone_type, :phone_number, service_type: []],
				)
		end
	end