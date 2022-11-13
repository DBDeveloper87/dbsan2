class ChallengesController < ApplicationController
	before_action :authenticate_user!, only: :new
	before_action :require_admin, only: :new
	before_action :set_challenge, only: :show

	def index
		@challenges = Challenge.all
	end

	def new
		@challenge = Challenge.new
	end

	def show
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

	private
		def create_params
			params.require(:challenge).permit(:title, :start, :end, :description)
		end

		def set_challenge
			@challenge = Challenge.find(params[:id])
		end

end
