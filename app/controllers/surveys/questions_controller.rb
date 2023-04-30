class Surveys::QuestionsController < SurveysController
	before_action :get_section, only: [:index, :new, :create, :update, :edit]
	before_action :set_question, only: [:edit, :update]

	def index
		@questions = @section.questions.order(position: :asc).all
	end

	def new
		@question = @section.questions.build
		@position = @section.questions.count + 1
	end

	def edit
		@option = @question.options.build
		render partial: "surveys/questions/edit", locals: {q: @question, 
			survey: @survey, section: @section, option: @option}
	end

	def create
		@question = @section.questions.create(create_params)

		if @question.save
			respond_to do |f|
				@option = @question.options.build
				f.turbo_stream
			end
		end
	end

	def update
		if @question.update(update_params)
			respond_to do |f|
				f.turbo_stream
			end
		end
	end

	private
		def get_section
			@survey = Survey.find_by(slug: params[:survey_slug])
			@section = @survey.sections.find_by(section_number: params[:sec_num])
		end

		def create_params
			params.require(:survey_question).permit(:survey_section_id, :position, :question_type)
		end

		def update_params
			params.require(:survey_question).permit(:survey_setion_id, :position, :question_type, 
				:title, :description, question_options_attributes: [:id, :_destroy, :name, 
					:logic, :sub_logic])
		end
		
		def set_question
			@question = @section.questions.find_by(position: params[:position])
		end
end
