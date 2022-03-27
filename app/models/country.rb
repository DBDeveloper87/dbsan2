class Country < ApplicationRecord
	has_many :state_provinces
	has_many :addresses
end
