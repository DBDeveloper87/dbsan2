class Survey < ApplicationRecord
  belongs_to :channel
  has_many :survey_sections
  before_create :add_slug

  def sections
    self.survey_sections
  end

  private
    def add_slug
      self.slug = self.title.parameterize
    end
end
