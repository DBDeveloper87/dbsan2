class QuestionOption < ApplicationRecord
  belongs_to :survey_question
  has_and_belongs_to_many :response_answers, optional: true
end
