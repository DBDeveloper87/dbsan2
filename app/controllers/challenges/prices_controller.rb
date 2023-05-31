class Challenges::PricesController < ApplicationController
	before_action :get_challenge
	before_action :set_price, only: [:edit, :update]
	before_action :authenticate_user!
	before_action :require_admin

	def index
		@prices = @challenge.prices.all
	end

	def new
		@price = @challenge.prices.build
	end

	def create
		@price = @challenge.prices.create(create_params)

		if @price.save
			redirect_to challenge_prices_path(@challenge)
		end
	end

	def update
		if @price.update(create_params)
			redirect_to challenge_prices_path(@challenge)
		end
	end

	private
		def get_challenge
			@challenge = Challenge.find(params[:challenge_id])
		end

		def create_params
			params.require(:price).permit(:name, :description, :price, 
				:shirt, :shirt_description, :shirt_image, perks: [])
		end

		def set_price
			@price = @challenge.prices.find(params[:id])
		end
end
