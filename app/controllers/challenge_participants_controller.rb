class ChallengeParticipantsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create]
	before_action :get_challenge, only: [:new, :create]
	before_action :set_participant, only: :show

	def new
		if @challenge.challenge_participants.map { |i| i.id == current_user.id }
			@participant = @challenge.challenge_participants.find_by(user_id: current_user.id)
			redirect_to challenge_participant_path(@challenge, @participant)
		else
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
	end

	def show
		@donations = @participant.donations.where(paid: true).all
		@raised = []
		@donations.each do |d|
			@raised.append(d.amount.to_i / 100.0)
		end
		@raised = @raised.sum
		@percent = @raised * 100 / 150

	end

	def create
		@user = current_user.id
		@registrant = @challenge.challenge_participants.build(register_params)

		if @registrant.save
			ChallengeMailer.with(registrant: @registrant).registered.deliver_now
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

		def set_participant
			@participant = ChallengeParticipant.find(params[:id])
			@challenge = @participant.challenge
		end

end
