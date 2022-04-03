class CampApplicationBi < ApplicationRecord
  belongs_to :camp_application

  serialize :interests
end
