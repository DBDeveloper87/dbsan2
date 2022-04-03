class CampApplicationMedical < ApplicationRecord
  belongs_to :camp_application

  serialize :medical_conditions
end
