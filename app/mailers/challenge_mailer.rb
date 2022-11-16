class ChallengeMailer < ApplicationMailer
	default from: "DBSAN Challenges <no-reply@dbsan.org>"

	def registered
		@registration = params[:registrant]
		@name = @registration.first_name
		mail(
			to: @registration.user.email, 
			bcc: "<info@dbsan.org>",
			subject: "Thank you for registering!")
	end
end
