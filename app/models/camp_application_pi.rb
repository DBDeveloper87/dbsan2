class CampApplicationPi < ApplicationRecord
  belongs_to :camp_application
  has_one :address
  accepts_nested_attributes_for :address
  has_many :phone_numbers
  accepts_nested_attributes_for :phone_numbers
end
