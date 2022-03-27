class CampApplicationType < ApplicationRecord
  belongs_to :camp
  has_many :camp_applications
end
