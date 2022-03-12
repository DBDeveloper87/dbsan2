module EventsHelper
	def name
		@event.event_attendees.each do |person|
			person.name = person.user.profile.first_name + person.user.profile.last_name
		end
	end

end
