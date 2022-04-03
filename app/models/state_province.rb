class StateProvince < ApplicationRecord
	belongs_to :country
	has_many :counties
	has_many :addresses
end
