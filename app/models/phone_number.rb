class PhoneNumber < ApplicationRecord
  belongs_to :camp_application_pi
  belongs_to :camp_application_emergency
  belongs_to :profile
end
