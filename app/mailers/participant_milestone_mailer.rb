class ParticipantMilestoneMailer < ApplicationMailer
	default from: "DBSAN Challenges <no-reply@dbsan.org>"

	def earned_milestone(participant, milestone)
		@email = participant.user.email
		@name = participant.first_name
		@milestone = milestone
		mail(
			to: @email, 
			bcc: "<info@dbsan.org>",
			subject: "Congrats on your new milestone!")
	end
end
