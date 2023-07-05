class Surveys::InterviewersController < SurveysController
	before_action :get_survey, only: [:index, :new, :create]

	def index
		@interviewers = @survey.interviewers.all.sort { |a, b| a.last_name <=> b.last_name}
	end

	def new
		@interviewer = @survey.interviewers.build
		@members_list_options = @survey.channel.member_list_options
	end

	def create
		@interviewer = @survey.interviewers.create(create_params)

		if @interviewer.save
			redirect_to survey_interviewers_path(survey_slug: @survey.slug)
		end
	end

	private
		def get_survey
			@survey = Survey.find_by_slug(params[:survey_slug])
		end

		def create_params
			params.require(:interviewer).permit(:user_id)
		end

	
end
