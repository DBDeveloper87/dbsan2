class SurveySection < ApplicationRecord
	belongs_to :survey
	has_many :survey_questions

	def questions
		self.survey_questions
	end

end
