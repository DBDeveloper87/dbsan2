class CampApplicationMailer < ApplicationMailer
	default from: "DeafBlind Retreat at Isola Bella <no-reply@dbsan.org>"

	def application_started
		@app = params[:camp_application]
		@name = @app.user.profile.first_name + " " + @app.user.profile.last_name
		mail(to: "info@dbsan.org", subject: "Fabulous News!")
	end

	def submission_receipt
		@app = params[:camp_application]
		@name = @app.user.profile.first_name + " " + @app.user.profile.last_name
		mail(to: "#{@app.user.email}", subject: "Thank you for your application, #{@name}.")
	end

	def submission_notification
		@app = params[:camp_application]
		@name = @app.user.profile.first_name + " " + @app.user.profile.last_name
		mail(to: "info@dbsan.org", subject: "An application has been submitted.")
	end
end
