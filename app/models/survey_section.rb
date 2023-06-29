class SurveySection < ApplicationRecord
	belongs_to :survey
	has_many :survey_questions, dependent: :destroy

	before_destroy :update_positions

	def questions
		self.survey_questions
	end

	private
		def update_positions
      		sections = self.survey.sections
      		sections[self.section_number..sections.count - 1].each do |s|
        		s.section_number = s.section_number - 1
        		s.save
      		end
    	end

end
