class CampApplicationEmergency < ApplicationRecord
  belongs_to :camp_application
  has_many :phone_numbers
  accepts_nested_attributes_for :phone_numbers
end
