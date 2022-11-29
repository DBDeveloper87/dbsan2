class ChallengesController < ApplicationController
	before_action :authenticate_user!, only: :new
	before_action :require_admin, only: [:new, :edit, :update]
	before_action :set_challenge, only: [:show, :edit, :update]

	def index
		@challenges = Challenge.all
	end

	def new
		@challenge = Challenge.new
		@banner = @challenge.photo.build
	end

	def edit
		if @challenge.photo.nil?
			@banner = @challenge.photl.build
		else
			@banner = @challenge.photo
		end
	end

	def show
		@participants = @challenge.challenge_participants
		@participant = @challenge.challenge_participants.find_by(user_id: current_user&.id)
		@users = []
		@participants.each do |p|
			@users.append(p.user_id)
		end
		@donor_count = @challenge.donations.count
		@top_donors = @challenge.top_donors
		@raised = []
		@challenge.donations.each do |d|
			@raised.append(d.amount.to_i / 100.0)
		end
		@raised = @raised.sum
		@exercise = @challenge.milestones.where(milestone_type: "Exercise").all
		@fundraising = @challenge.milestones.where(milestone_type: "Fundraising").all.order(goal: :asc)
		@faqs = @challenge.faqs.all.order(group_number: :asc).order(question_number: :asc)
		@groups = []
		@faqs.each do |f|
			@groups.append({id: f.group_number, group: f.question_group})
		end
		@groups = @groups.uniq { |k| k[:id]}
	
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
			params.require(:challenge).permit(:title, :start, :end, :description, 
				photo_attributes: [ :id, :label, :image_type, :alt_text, :description, :file])
		end

		def set_challenge
			@challenge = Challenge.find(params[:id])
		end

end
