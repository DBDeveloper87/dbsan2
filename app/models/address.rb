class Address < ApplicationRecord
	belongs_to :profile
	belongs_to :camp_application_pi
	belongs_to :state_province
	belongs_to :county
end
