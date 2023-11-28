class DonationsController < ApplicationController
	before_action :get_participant, only: :new
	before_action :set_thank_you_note, only: :thank_you_note
	before_action :set_donation, only: :update

	def new
		@donation = Donation.new
		unless @challenge.nil?
			@program = "#{@challenge.title} for #{@participant.full_name}"
		else
			@program = "General Budget"
		end
	end

	def create
		@donation = Donation.create(create_params)

		if @donation.save
			if Rails.env.development?
				success_url = "http://localhost:3000/donations_success?session_id={CHECKOUT_SESSION_ID}"
				cancel_url = "http://localhost:3000/"
			elsif Rails.env.production?
				success_url = "https://www.dbsan.org/donations_success?session_id={CHECKOUT_SESSION_ID}"
				cancel_url = "https://www.dbsan.org/"
			end

			data = {
				line_items: [{
      				price_data: {
        				currency: 'usd',
        				product_data: {
          				name: @donation.program
        			},
        			unit_amount: @donation.amount.to_i
      				},
      				quantity: 1,
    			}], 
    			mode: 'payment',
    			customer_email: @donation.email,
    			success_url: success_url,
    			cancel_url: cancel_url
			}

			session = Stripe::Checkout::Session.create(data)
			redirect_to session.url, allow_other_host: true
		end
	end

	def success
		@session = Stripe::Checkout::Session.retrieve(params[:session_id])
  		@customer = Stripe::Customer.retrieve(@session.customer)
  		@line_items = Stripe::Checkout::Session.list_line_items(@session.id)	
		@data = @line_items[:data]
		@program = @data.first[:description]
		@email = @customer[:email]
		@name = @customer[:name]
		@address = @customer[:address]
		@zip = @address[:postal_code]
		
		@donation = Donation.find_by(email: @email, program: @program, paid: nil)
		@donation.name = @name
		@donation.paid = true
		@donation.zip = @zip
		@donation.save
		
		DonationMailer.with(donation: @donation.id).tax_deductible.deliver_now
		DonationMailer.with(donation: @donation.id).notify_participant.deliver_now
		redirect_to donations_thank_you_path(donation: @donation.id)
	end

	def thank_you
		@donation = Donation.find_by(id: params[:donation])
		@first_name = @donation.name.split(" ").first
		@email = @donation.email
	end

	def thank_you_note
		@participant_name = @donation.challenge_participant.full_name
	end

	def update
		@participant = @donation.challenge_participant
		@challenge = @participant.challenge

		if @donation.update(thank_you_params)
			DonationMailer.with(donation: @donation).thank_you_note.deliver_now
			@donation.tyn_sent_at = Time.now
			@donation.save
			redirect_to challenge_participant_path(@challenge, @participant)
		end
	end


	private
		def get_participant
			if params[:participant_id].present?
				@participant = ChallengeParticipant.find_by(id: params[:participant_id])
				@challenge = @participant.challenge
			end
		end

		def set_thank_you_note
			@donation = Donation.find_by(id: params[:donation_id])
		end

		def set_donation
			@donation = Donation.find(params[:id])
		end

		def thank_you_params
			params.require(:donation).permit(:thank_you_note)
		end

		def create_params
			params.require(:donation).permit(:program, :amount, :other_amount, :email, :user_id, :challenge_participant_id)
		end

		
end
