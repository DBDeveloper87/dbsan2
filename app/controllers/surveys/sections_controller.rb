class Surveys::SectionsController < SurveysController
	before_action :set_section, only: [:edit, :update]

	def edit
		if params[:part].present?
			if params[:part] == "title"
				render partial: "surveys/sections/edit_title", locals: {section: @section}
			elsif params[:part] == "description"
				render partial: "surveys/sections/edit_description", locals: {section: @section}
			end
		end
	end

	def create
		@survey = Survey.find_by(slug: params[:survey_slug])
		@sections = @survey.sections.order(section_number: :asc)
		if @sections.count == 0
			@new_num = 1
		else
			@new_num = @sections.last.section_number + 1
		end
		@section = @survey.sections.create(title: "Untitled", section_number: @new_num)

		if @section.save
			redirect_to edit_survey_section_path(survey_slug: @survey.slug, sec_num: @section.section_number)
		end
	end

	def update
		if @section.update(update_params)
			redirect_to edit_survey_section_path(survey_slug: @survey.slug, sec_num: @section.section_number)
		end
	end

	private
		def set_section
			@survey = Survey.find_by(slug: params[:survey_slug])
			@channel = @survey.channel
			@section = @survey.sections.find_by(section_number: params[:sec_num])
		end

		def update_params
			params.require(:survey_section).permit(:title, :content)
		end
end
