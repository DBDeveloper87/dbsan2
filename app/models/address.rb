class Address < ApplicationRecord
	belongs_to :state_province
	belongs_to :country
	belongs_to :camp_application_pi
end
