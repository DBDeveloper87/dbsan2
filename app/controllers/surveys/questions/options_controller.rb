class Surveys::Questions::OptionsController < Surveys::QuestionsController
	before_action :setup

	def new
	end

	def destroy
	end

	private

		def setup
			@survey = Survey.find_by(slug: params[:survey_slug])
			@channel = @survey.channel
			@section = @survey.sections.find_by(section_number: params[:sec_num])
			@question = @section.questions.find_by(position: params[:question_position])
			@options = @question.options
		end

end
