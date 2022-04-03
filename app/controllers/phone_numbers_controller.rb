class PhoneNumbersController < ApplicationController
	def new
		@phone = PhoneNumber.new

		#render partial: "phone_number"	
	end

	def create
		@phone = PhoneNumber.create(phone_params)
		
		respond_to do |format|
			if @phone.save
				format.html {redirect_to root_path}
			else
				format.html { redirect_to camps_path }
			end
		end
	end

	private
		def phone_params
			params.require(:phone_number).permit(:user_id, :camp_application_pi_id, :phone_number)
		end
end
