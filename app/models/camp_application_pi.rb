class CampApplicationPi < ApplicationRecord
  belongs_to :camp_application
  serialize :gender
  serialize :pronouns
  has_one :address
  accepts_nested_attributes_for :address, allow_destroy: true
  has_many :phone_numbers
  accepts_nested_attributes_for :phone_numbers
end
