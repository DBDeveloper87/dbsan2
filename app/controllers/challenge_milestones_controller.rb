class ChallengeMilestonesController < ApplicationController
	before_action :get_challenge, only: [:index, :new, :create]

	def index
		@exercise = @challenge.milestones.where(milestone_type: "Exercise").all
		@fundraising = @challenge.milestones.where(milestone_type: "Fundraising").all.order(goal: :desc)
	end

	def new
		@milestone = @challenge.milestones.build
	end

	def create
		@milestone = @challenge.milestones.build(create_params)

		if @milestone.save
			redirect_to challenge_milestones_path(@challenge)
		end
	end

	private
		def get_challenge
			@challenge = Challenge.find_by(id: params[:challenge_id])
		end

		def create_params
			params.require(:challenge_milestone).permit(:milestone_type, :name, :prize, :goal, :goal_unit)
		end
end
