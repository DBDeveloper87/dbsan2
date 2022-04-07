class CampApplicationMailer < ApplicationMailer
	default from: "DeafBlind Retreat at Isola Bella <no-reply@dbsan.org>"

	def application_started
		@app = params[:camp_application]
		@name = @app.user.profile.first_name + " " + @app.user.profile.last_name
		mail(to: "patrick.vellia@gmail.com", subject: "Fabulous News!")
	end
end
