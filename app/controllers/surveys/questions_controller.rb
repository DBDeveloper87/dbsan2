class Surveys::QuestionsController < SurveysController
	before_action :get_section, only: [:index, :new]

	def index
		@questions = @section.questions.order(position: :asc).all
	end

	def new
		@question = @section.questions.build
		@position = @section.questions.count + 1
	end

	private
		def get_section
			@survey = Survey.find_by(slug: params[:survey_slug])
			@section = @survey.sections.find_by(section_number: params[:sec_num])
		end
end
