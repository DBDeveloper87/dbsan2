class CampApplicationMatching < ApplicationRecord
  belongs_to :camp_application
  has_many :camp_application_matchnps
  accepts_nested_attributes_for :camp_application_matchnps, reject_if: :all_blank, allow_destroy: true
end
