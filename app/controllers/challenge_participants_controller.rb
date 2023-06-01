class ChallengeParticipantsController < ApplicationController
	before_action :authenticate_user!, only: [:index, :new, :create]
	before_action :require_admin, only: :index
	before_action :get_challenge, only: [:index, :shirts, :new, :create]
	before_action :set_participant, only: :show

	def index
		@participants = @challenge.challenge_participants.all.order(last_name: :asc)
		@fundraising = @challenge.milestones.where(milestone_type: "Fundraising").all.order(goal: :asc)
		@exercise = @challenge.milestones.where(milestone_type: "Exercise").all.order(goal: :asc)
		@emails = []
		@participants.each do |p|
			@emails.append(p.user.email)
		end
		@emails = @emails.join(", ")
	end

	def shirts
		@participants = @challenge.challenge_participants.all
		@small_count = @challenge.challenge_participants.where(shirt_size: "s").count
		@medium_count = @challenge.challenge_participants.where(shirt_size: "m").count
	end


	def new
		if current_user.id.in?(@challenge.challenge_participants.map { |i| i.user_id})
			@participant = @challenge.challenge_participants.find_by(user_id: current_user.id)
			redirect_to challenge_participant_path(@challenge, @participant)
		else
			@registrant = ChallengeParticipant.new
			@first_name = current_user.profile.first_name
			@last_name = current_user.profile.last_name
			@address = current_user.profile.addresses.find_by(address_type: "Primary Address")
			unless @address.nil?
				@line_1 = @address.address_l1
				@line_2 = @address.address_l2
				@city = @address.city
				@state = @address.state_province.code
				@zip = @address.zippostal
				@country = @address.state_province.country.name
			end
		end
	end

	def show
		@donations = @participant.donations.where(paid: true).all.order(amount_deci: :desc)
		@raised = []
		@donations.each do |d|
			@raised.append(d.amount_deci)
		end
		@raised = @raised.sum
		if @raised.between?(0, 150)
			@percent = @raised * 100 / 150
		elsif @raised.between?(151, 300)
			@percent = @raised * 100 / 300
		elsif @raised.between?(301, 1000)
			@percent = @raised * 100 / 1000
		elsif @raised > 1000
			@percent = @raised * 100 / 5000
		end
		@unique_emails = @donations.uniq { |d| d.email }
		@milestones = @participant.milestones
		@activities = @participant.exercise_trackers.all.order(created_at: :desc)
	end

	def create
		@registrant = @challenge.challenge_participants.build(register_params)
		@registrant.user_id = current_user.id
		unless @registrant.donations.empty?
			@registrant.donations.first.user_id = current_user.id
			@registrant.donations.first.email = current_user.email
			@registrant.donations.first.name = @registrant.full_name
		end

		if @registrant.save
			@challenge = @registrant.challenge
			ChallengeMailer.with(registrant: @registrant).registered.deliver_now
			if @registrant.price.price == 0
				redirect_to challenge_participant_path(@challenge, @registrant)
			else
				if Rails.env.development?
					success_url = "http://localhost:3000/registration_success?session_id={CHECKOUT_SESSION_ID}"
					cancel_url = challenge_url(@challenge)
				elsif Rails.env.production?
					success_url = "https://www.dbsan.org/registration_success?session_id={CHECKOUT_SESSION_ID}"
					cancel_url = challenge_url(@challenge)
				end

				product_name = "#{@challenge.title} #{@registrant.price.name} Registration"
				line_items = []
				line_items.append(
						{
      						price_data: {
        						currency: 'usd',
        						product_data: {
          						name: product_name
        					},
        					unit_amount: (@registrant.price.price * 100).to_i
      						},
      						quantity: 1,
    					}
					)

				unless @registrant.donations.empty?
					line_items.append(
							{
      							price_data: {
        							currency: 'usd',
        							product_data: {
          							name: "#{@registrant.donations.first.program} Tax Deductible Donation"
        						},
        						unit_amount: @registrant.donations.first.amount.to_i
      							},
      							quantity: 1,
    						}
						)
				end

				data = {
					line_items: line_items, 
    				mode: 'payment',
    				customer_email: current_user.email,
    				success_url: success_url,
    				cancel_url: cancel_url
				}

				session = Stripe::Checkout::Session.create(data)
				redirect_to session.url, allow_other_host: true
			end
		end
	end

	def stripe_success
		@session = Stripe::Checkout::Session.retrieve(params[:session_id])
  		@customer = Stripe::Customer.retrieve(@session.customer)
  		@line_items = Stripe::Checkout::Session.list_line_items(@session.id)	
		@data = @line_items[:data]
		@registration = @data.first[:description]
		
		@email = @customer[:email]
		@name = @customer[:name]
		@address = @customer[:address]
		@zip = @address[:postal_code]
		
		@user = User.find_by(email: @email)
		challenge_participants = ChallengeParticipant.where(user_id: @user.id).all
		@participant = nil
		challenge_participants.each do |c|
			challenge = c.challenge.title
			price_name = c.price.name
			if @registration == "#{challenge} #{price_name} Registration"
				c.paid = true
				c.save
				@participant = c
			end
		end

		@challenge = @participant.challenge

		if @data.count > 1
			@program = @data.last[:description]
			@program = @program.sub(" Tax Deductible Donation", "")

			@donation = @participant.donations.first
			@donation.paid = true
			@donation.zip = @zip
			@donation.save
		
			DonationMailer.with(donation: @donation.id).tax_deductible.deliver_now
			DonationMailer.with(donation: @donation.id).notify_participant.deliver_now
		end
		redirect_to challenge_participant_path(@challenge, @participant)
	end

	private
		def get_challenge
			@challenge = Challenge.find(params[:challenge_id])
		end

		def register_params
			params.require(:challenge_participant).permit(:first_name, :last_name, :line_1, :line_2, 
				:city, :state, :zip, :country, :price_id, :shirt_size, 
				:user_id, donations_attributes: [:id, :challenge_participant_id, 
					:program, :amount, :user_id, :email])
		end

		def set_participant
			@participant = ChallengeParticipant.find(params[:id])
			@challenge = @participant.challenge
		end

end
