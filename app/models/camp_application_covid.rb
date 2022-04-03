class CampApplicationCovid < ApplicationRecord
  belongs_to :camp_application

  serialize :vaccination_type
end

