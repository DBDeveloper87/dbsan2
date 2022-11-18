class DonationMailer < ApplicationMailer
	default from: "DBSAN Donations <no-reply@dbsan.org>"

	def tax_deductible
		@donation = Donation.find_by(id: params[:donation])
		@name = @donation.name
		@first_name = @name.split(" ").first
		@amount = @donation.amount.to_i
		mail(
			to: @donation.email, 
			bcc: "<info@dbsan.org>",
			subject: "Your Tax Deductible Receipt")
	end

	def notify_participant
		@donation = Donation.find_by(id: params[:donation])
		@participant = @donation.challenge_participant
		@challenge = @participant.challenge
		@participant_name = @participant.first_name
		@donor_name = @donation.name
		@amount = @donation.amount.to_i
		mail(
			to: @participant.user.email, 
			bcc: "<info@dbsan.org>",
			subject: "You just received a donation toward your Challenge!")
	end

	def thank_you_note
		@donation = Donation.find_by(id: params[:donation])
		@email = @donation.email
		@participant_name = @donation.challenge_participant.full_name
		@note = @donation.thank_you_note
		mail(
			to: @email, 
			subject: "A personalized thank you from #{@participant_name}")
	end
end
