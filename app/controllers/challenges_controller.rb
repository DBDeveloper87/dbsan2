class ChallengesController < ApplicationController
	before_action :authenticate_user!, only: :new
	before_action :require_admin, only: [:new, :edit, :update]
	before_action :set_challenge, only: [:show, :edit, :update]

	def index
		@challenges = Challenge.all
	end

	def new
		@challenge = Challenge.new
	end

	def edit
	end

	def show
		@participants = @challenge.challenge_participants
		@participant = @challenge.challenge_participants.find_by(user_id: current_user&.id)
		@users = []
		@participants.each do |p|
			@users.append(p.user_id)
		end
		@donor_count = []
		@challenge.donations.each do |d|
			@donor_count.append(d.email)
		end
		@donor_count = @donor_count.uniq.count
		@raised = []
		@challenge.donations.each do |d|
			@raised.append(d.amount.to_i / 100.0)
		end
		@raised = @raised.sum
		@exercise = @challenge.milestones.where(milestone_type: "Exercise").all
		@fundraising = @challenge.milestones.where(milestone_type: "Fundraising").all.order(goal: :asc)
	
	end

	def create
		@challenge = Challenge.create(create_params)

		@challenge.start = @challenge.start + 5.hours
		@challenge.end = @challenge.end + 5.hours
		@challenge.save

		if @challenge.save
			redirect_to challenge_path(@challenge)
		end
	end

	def update
		if @challenge.update(create_params)
			redirect_to challenge_path(@challenge)
		end
	end

	private
		def create_params
			params.require(:challenge).permit(:title, :start, :end, :description)
		end

		def set_challenge
			@challenge = Challenge.find(params[:id])
		end

end
