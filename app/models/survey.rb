class Survey < ApplicationRecord
  belongs_to :channel
  has_many :survey_sections, dependent: :destroy
  has_many :survey_responses
  before_create :add_slug

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
