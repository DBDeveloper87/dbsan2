class Country < ApplicationRecord
	has_many :state_provinces
	has_many :counties, through: :state_provinces
	has_many :addresses, through: :state_provinces
	has_many :phone_numbers
end
