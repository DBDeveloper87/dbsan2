class Camp < ApplicationRecord
	has_many :camp_applications, dependent: :destroy
	has_many :camp_application_types
end
