class CampApplication < ApplicationRecord
  belongs_to :camp_application_type
  belongs_to :camp
  belongs_to :user
  validates_uniqueness_of :camp, scope: :user_id
  has_one :camp_application_pi, dependent: :destroy
  has_one :camp_application_bi, dependent: :destroy
  has_one :camp_application_inc, dependent: :destroy
  has_one :camp_application_matching, dependent: :destroy
  has_many :camp_application_matchnps, through: :camp_application_matching
  has_one :camp_application_lodging, dependent: :destroy
  has_one :camp_application_meal, dependent: :destroy
  has_one :camp_application_medical, dependent: :destroy
  has_one :camp_application_emergency, dependent: :destroy
  has_one :camp_application_c3, dependent: :destroy
  has_one :camp_application_permission, dependent: :destroy
  has_one :camp_application_covid, dependent: :destroy
  has_one :camp_application_ceu, dependent: :destroy
  has_one :camp_application_training, dependent: :destroy
  has_one :camp_application_ca, dependent: :destroy
  has_one :camp_application_shift, dependent: :destroy
  has_one :camp_application_commitment, dependent: :destroy
end
