class ChallengeParticipantsController < ApplicationController
	before_action :authenticate_user!, only: [:index, :new, :create]
	before_action :require_admin, only: :index
	before_action :get_challenge, only: [:index, :new, :create]
	before_action :set_participant, only: :show

	def index
		@participants = @challenge.challenge_participants.all.order(last_name: :asc)
		@fundraising = @challenge.milestones.where(milestone_type: "Fundraising").all.order(goal: :asc)
	end

	def new
		if current_user.id.in?(@challenge.challenge_participants.map { |i| i.user_id})
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
		@donations = @participant.donations.where(paid: true).all.order(amount_deci: :desc)
		@raised = []
		@donations.each do |d|
			@raised.append(d.amount_deci)
		end
		@raised = @raised.sum
		if @raised.between?(0, 150)
			@percent = @raised * 100 / 150
		elsif @raised.between?(151, 300)
			@percent = @raised * 100 / 300
		elsif @raised.between?(301, 1000)
			@percent = @raised * 100 / 1000
		elsif @raised > 1000
			@percent = @raised * 100 / 5000
		end
		@unique_emails = @donations.uniq { |d| d.email }
		@milestones = @participant.milestones
	end

	def create
		@user = current_user.id
		@registrant = @challenge.challenge_participants.build(register_params)

		if @registrant.save
			@challenge = @registrant.challenge
			ChallengeMailer.with(registrant: @registrant).registered.deliver_now
			redirect_to challenge_participant_path(@challenge, @registrant)
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
