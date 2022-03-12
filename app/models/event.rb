class Event < ApplicationRecord
	has_many :event_attendees, dependent: :destroy
	has_one :virtual_space
	after_create :create_virtual_space
	has_many :zoom_meetings, through: :virtual_space

	validates :title, presence: true
	validates :description, presence: true
	validate :valid_date_range?

	def valid_date_range?
		return unless start_time? && end_time?

		if !end_time.after?(start_time)
			errors.add(:start_time, "Start Date Time must be before End Date Time")
			errors.add(:end_time, "End Date Time must be after Start Date Time")
		end
	end

	def duration
		(end_time.to_f - start_time.to_f) / 3600
	end

	def same_date?
		start_time.strftime("%y %m %d") == end_time.strftime("%y %m %d")
	end

	def create_virtual_space
		if self.has_virtual_space?
			(self.virtual_space = VirtualSpace.new(event_id: self.id)).save
		end
	end
end
