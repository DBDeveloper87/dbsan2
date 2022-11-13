class Survey < ApplicationRecord
  belongs_to :channel
  has_many :survey_sections

  def sections
    self.survey_sections
  end
end
