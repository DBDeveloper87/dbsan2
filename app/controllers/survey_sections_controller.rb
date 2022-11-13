class SurveySectionsController < Channels::MyChannelController
	before_action :set_section, only: [:edit, :update]

	def edit
	end

	def create
		@survey = Survey.find_by(id: params[:survey_id])
		@sections = @survey.sections.order(section_number: :asc)
		if @sections.count == 0
			@new_num = 1
		else
			@new_num = @sections.last.section_number + 1
		end
		@section = @survey.sections.create(title: "Untitled", section_number: @new_num)

		if @section.save
			redirect_to edit_survey_section_path(@survey, @section)
		end
	end

	def update
		if @section.update(update_params)
			redirect_to edit_survey_section_path(@survey, @section)
		end
	end

	private
		def set_section
			@section = SurveySection.find(params[:id])
			@survey = @section.survey
		end

		def update_params
			params.require(:survey_section).permit(:title, :content)
		end
end
