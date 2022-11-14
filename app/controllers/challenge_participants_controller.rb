class ChallengeParticipantsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create]
	before_action :get_challenge, only: [:new, :create]

	def new
		@registrant = ChallengeParticipant.new
		@first_name = current_user.profile.first_name
		@last_name = current_user.profile.last_name
		@address = current_user.profile.addresses.find_by(address_type: "Primary Address")
		unless @address.nil?
			@line_1 = @address.address_l1
			@line_2 = @address.address_l2
			@city = @address.city
			@state = @address.state_province.code
			@zip = @address.zippostal
			@country = @address.state_province.country.name
		end
	end

	def create
		@user = current_user.id
		@registrant = @challenge.challenge_participants.build(register_params)

		if @registrant.save
			redirect_to challenges_path
		end
	end

	private
		def get_challenge
			@challenge = Challenge.find(params[:challenge_id])
		end

		def register_params
			params.require(:challenge_participant).permit(:first_name, :last_name, :line_1, :line_2, 
				:city, :state, :zip, :country, :shirt_size, :user_id)
		end

end
