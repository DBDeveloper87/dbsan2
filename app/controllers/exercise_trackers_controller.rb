class ExerciseTrackersController < ApplicationController
	before_action :get_participant, only: [:new, :create]
	before_action :set_activity, only: :destroy
	def new
		@activity = @participant.exercise_trackers.build
		@image = @activity.build_photo
	end

	def create
		@activity = @participant.exercise_trackers.build(create_params)

		if @activity.save
			redirect_to challenge_participant_path(@challenge, @participant)
		end
	end

	def destroy
		if current_user.id == @participant.user.id
			@activity.destroy
			redirect_to challenge_participant_path(@challenge, @participant)
		end
	end

	private
		def get_participant
			@participant = ChallengeParticipant.find_by(id: params[:participant_id])
			@challenge = @participant.challenge
		end

		def set_activity
			@activity = ExerciseTracker.find_by(id: params[:id])
			@participant = @activity.challenge_participant
			@challenge = @participant.challenge
		end

		def create_params
			params.require(:exercise_tracker).permit(:activity, :distance, :distance_unit, 
				:time_hour, :time_minute,
			 :time_second, :comment, photo_attributes: [:file, :alt_text, :image_type])
		end
end
