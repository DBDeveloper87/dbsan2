class CampApplicationEmergency < ApplicationRecord
  belongs_to :camp_application
  has_one :phone_number
  accepts_nested_attributes_for :phone_number
end
