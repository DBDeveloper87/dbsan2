class FaQsController < ApplicationController
	before_action :authenticate_user!
	before_action :get_challenge, only: [:new, :create, :index]

	def index
		@faqs = @challenge.faqs.all.order(group_number: :asc).order(question_number: :asc)
		@groups = []
		@faqs.each do |f|
			@groups.append({id: f.group_number, group: f.question_group})
		end
		@groups = @groups.uniq { |k| k[:id]}
	end

	def new
		@faq = @challenge.faqs.new
	end

	def create
		@faq = @challenge.faqs.create(create_params)

		if @faq.save
			redirect_to challenge_faqs_path(@challenge)
		end
	end

	private
		def get_challenge
			@challenge = Challenge.find(params[:challenge_id])
		end

		def create_params
			params.require(:frequently_asked_question).permit(:group_number, 
				:question_group, :question_number, :question, :answer)
		end

end
