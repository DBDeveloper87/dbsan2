class ChallengeMilestonesController < ApplicationController
	before_action :authenticate_user!
	before_action :require_admin
	before_action :get_challenge, only: [:index, :new, :create]
	before_action :set_milestone, only: [:edit, :update]

	def index
		@exercise = @challenge.milestones.where(milestone_type: "Exercise").all
		@fundraising = @challenge.milestones.where(milestone_type: "Fundraising").all.order(goal: :asc)
	end

	def new
		@milestone = @challenge.milestones.build
		@badge = @milestone.build_photo
	end

	def edit
		if @milestone.photo.nil?
			@badge = @milestone.build_photo
		else
			@badge = @milestone.photo
		end
	end

	def create
		@milestone = @challenge.milestones.build(create_params)

		if @milestone.save
			redirect_to challenge_milestones_path(@challenge)
		end
	end

	def update
		if @milestone.update(create_params)
			redirect_to challenge_milestones_path(@challenge)
		end
	end

	private
		def get_challenge
			@challenge = Challenge.find_by(id: params[:challenge_id])
		end

		def set_milestone
			@challenge = Challenge.find_by(id: params[:challenge_id])
			@milestone = @challenge.milestones.find(params[:id])
		end

		def create_params
			params.require(:challenge_milestone).permit(:milestone_type, :name, :prize, :goal, :goal_unit, 
				photo_attributes: [:file, :image_type])
		end
end
