class ParticipantMilestonesController < ApplicationController
	before_action :get_challenge_participant, only: [:new, :create]

	def new
		@milestone = ParticipantMilestone.new
	end

	def create
		@milestone = ParticipantMilestone.create(create_params)

		if @milestone.save
			redirect_to challenge_participants_path(@challenge)
		end
	end

	private
		def get_challenge_participant
			@challenge = Challenge.find(params[:challenge_id])
		end

		def create_params
			params.require(:participant_milestone).permit(:challenge_milestone_id, 
				:challenge_participant_id)
		end


end
