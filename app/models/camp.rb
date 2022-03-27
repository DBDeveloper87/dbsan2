class Camp < ApplicationRecord
	has_many :camp_applications
	has_many :camp_application_types
end
