class SurveyResponse < ApplicationRecord
  belongs_to :survey
  belongs_to :user, optional: true
  has_many :response_answers
  accepts_nested_attributes_for :response_answers
  belongs_to :interviewer, optional: true
  has_many :interviewees
  accepts_nested_attributes_for :interviewees, reject_if: :all_blank, allow_destroy: true
  
  enum status: {created: 0,
                in_progress: 1,
                awaiting_review: 2,
                completed: 3
  }

  def answers
    self.response_answers
  end
end
