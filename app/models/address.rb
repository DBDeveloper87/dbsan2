class Address < ApplicationRecord
	belongs_to :profile, optional: true
	belongs_to :camp_application_pi, optional: true
	belongs_to :state_province, optional: true
	belongs_to :county, optional: true
end
