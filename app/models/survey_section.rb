class SurveySection < ApplicationRecord
	belongs_to :survey
	has_many :survey_questions, dependent: :destroy

	def questions
		self.survey_questions
	end

end
