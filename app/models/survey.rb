class Survey < ApplicationRecord
  belongs_to :channel
  has_many :survey_sections, dependent: :destroy
  has_many :survey_responses
  has_many :interviewers

  before_create :add_slug

  enum survey_type: {survey: 0,
                    open_interview: 1,
                    camp_application: 2,
                    non_graded_quiz: 3,
                    graded_quiz: 4
  }

  def sections
    self.survey_sections
  end

  def responses
    self.survey_responses
  end

  private
    def add_slug
      self.slug = self.title.parameterize
    end
end
