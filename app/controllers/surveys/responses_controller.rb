class Surveys::ResponsesController < SurveysController
	skip_before_action :authenticate_user!, only: [:create, :edit]
	before_action :set_response, only: [:edit, :update]

	def edit
		@section = @survey.sections.find_by(section_number: params[:sec_num])
		@questions = @section.questions.order(position: :asc).all
	end

	def create
		@survey = Survey.find_by(slug: params[:survey_slug])
		@response = @survey.responses.create(status: "created")

		if @response.save
			redirect_to edit_survey_response_path(survey_slug: @survey.slug, id: @response.id, sec_num: 1)
		end
	end

	def update
		if @response.update(update_params)
			if params[:sec_num].to_i == @survey.sections.count
				redirect_to survey_path(slug: @survey.slug)
			end
		end
	end

	private
		def set_response
			@survey = Survey.find_by(slug: params[:survey_slug])
			@response = @survey.responses.find(params[:id])
		end

		def update_params
			params.require(:survey_response).permit(response_answers_attributes: [
				:id, :survey_question_id, 
				:long_answer, question_option_ids: [] ])
		end

end
