class SurveyResponse < ApplicationRecord
  belongs_to :survey
  belongs_to :user, optional: true
  has_many :response_answers
  accepts_nested_attributes_for :response_answers

  def answers
    self.response_answers
  end
end
