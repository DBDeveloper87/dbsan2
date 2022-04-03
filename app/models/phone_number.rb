class PhoneNumber < ApplicationRecord
  belongs_to :user
  belongs_to :camp_application_pi, optional: true
  belongs_to :camp_application_emergency, optional: true
  belongs_to :country, optional: true
end
