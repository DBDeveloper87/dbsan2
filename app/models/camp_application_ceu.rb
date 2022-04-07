class CampApplicationCeu < ApplicationRecord
  belongs_to :camp_application

  serialize :certifications
end
