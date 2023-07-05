class Surveys::ResponsesController < SurveysController
	skip_before_action :authenticate_user!, only: [:create, :edit, :update]
	before_action :get_survey, only: :index
	before_action :set_response, only: [:edit, :update]

	def index
		filter = params[:list_filter]
		case filter
		when "all"
			@responses = @survey.responses.all
		when "created"
			@responses = @survey.responses.where(status: "created").all
		when "in_progress"
			@responses = @survey.responses.where(status: "in_progress").all
		when "awaiting_review"
			@responses = @survey.responses.where(status: "awaiting_review").all
		when "complete"
			@responses = @survey.responses.where(status: "complete").all
		end
	end

	def edit
		unless params[:sec_num].present?
			@section = @survey.sections.find_by(section_number: 1)
		else
			@section = @survey.sections.find_by(section_number: params[:sec_num])
		end

		unless @section.nil?
			@questions = @section.questions.order(position: :asc).all
		end
	end

	def create
		@survey = Survey.find_by(slug: params[:survey_slug])
		
		@response = @survey.responses.create(status: "created")

		if @response.save
			if params[:include_interviewer].present?
				@response.interviewer_id = @survey.interviewers.find_by(user_id: current_user&.id).id
				@response.save
			end

			redirect_to edit_survey_response_path(survey_slug: @survey.slug, id: @response.id, sec_num: 1)
		end
	end

	def update
		if @response.update(update_params)
			if params[:sec_num].to_i == @survey.sections.count
				redirect_to survey_path(slug: @survey.slug)
			else
				redirect_to edit_survey_response_path(survey_slug: @survey.slug, 
					id: @response.id, sec_num: params[:sec_num].to_i + 1)
			end
		end
	end

	private
		def get_survey
			@survey = Survey.find_by_slug(params[:survey_slug])
		end

		def set_response
			@survey = Survey.find_by(slug: params[:survey_slug])
			@response = @survey.responses.find(params[:id])
		end

		def update_params
			params.require(:survey_response).permit(
				interviewees_attributes: [:id, :_destroy, :first_name, :last_name],
				response_answers_attributes: [
				:id, :survey_question_id, 
				:long_answer, question_option_ids: [] ])
		end

end
