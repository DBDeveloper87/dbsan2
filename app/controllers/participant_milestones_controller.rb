class ParticipantMilestonesController < ApplicationController
	before_action :set_milestone, only: [:send_notification, :accept_or_decline, :thanks]
	before_action :authenticate_user!, only: [:create, :send_notification, :accept_or_decline, :update, :thanks]
	before_action :require_admin, only: [:create, :send_notification, :destroy]
	before_action :check_current_user, only: :accept_or_decline
	before_action :get_challenge_participant, only: :create
	before_action :get_milestone, only: :update
	before_action :already_answered, only: :accept_or_decline

	def create
		@milestone = ParticipantMilestone.create(create_params)

		if @milestone.save
			redirect_to challenge_participants_path(@challenge)
		end
	end

	def send_notification
		ParticipantMilestoneMailer.earned_milestone(@milestone).deliver_now
		@milestone.earned_milestone_sent_at = Time.now
		@milestone.save
		redirect_to challenge_participants_path(@challenge)
	end

	def accept_or_decline
		@name = @participant.first_name
		milestone_info = @milestone.challenge_milestone
		@milestone_name = milestone_info.name
		@type = milestone_info.milestone_type
		@prize = milestone_info.prize
	end

	def update
		if @milestone.update(update_params)
			redirect_to challenge_participant_milestone_thanks_path(@challenge, @milestone)
		end
	end

	def thanks
		@name = @participant.first_name
	end

	def destroy
		@milestone = ParticipantMilestone.find_by(id: params[:id])
		@challenge = @milestone.challenge_participant.challenge
		@milestone.destroy
		redirect_to challenge_participants_path(@challenge)
	end

	private
		def get_challenge_participant
			@challenge = Challenge.find(params[:challenge_id])
		end

		def set_milestone
			@milestone = ParticipantMilestone.find(params[:participant_milestone_id])
			@participant = @milestone.challenge_participant
			@challenge = @participant.challenge
		end

		def create_params
			params.require(:participant_milestone).permit(:challenge_milestone_id, 
				:challenge_participant_id)
		end

		def update_params
			params.require(:participant_milestone).permit(:id, :accept_prize)
		end

		def get_milestone
			@milestone = ParticipantMilestone.find(params[:id])
			@participant = @milestone.challenge_participant
			@challenge = @participant.challenge
		end

		def check_current_user
			unless @participant.user.id == current_user.id
				redirect_to root_path
			end
		end

		def already_answered
			unless @milestone.accept_prize.nil?
				redirect_to challenge_participant_path(@challenge, @participant)
			end
		end


end
