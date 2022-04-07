class CampApplicationShift < ApplicationRecord
	belongs_to :camp_application

	serialize :shifts
end
