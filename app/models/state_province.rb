class StateProvince < ApplicationRecord
	belongs_to :country
	has_many :addresses
end
