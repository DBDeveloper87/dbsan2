class ResponseAnswer < ApplicationRecord
  belongs_to :survey_response
  belongs_to :survey_question
  has_and_belongs_to_many :question_options, optional: true
end
