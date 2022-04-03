class CampApplicationInc < ApplicationRecord
  belongs_to :camp_application

  serialize :identity
  serialize :communication_pref
end
