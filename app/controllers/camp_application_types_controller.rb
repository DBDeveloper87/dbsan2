class CampApplicationTypesController < ApplicationController
	before_action :get_camp, only: [:new, :create]

	def new
		@type = @camp.camp_application_types.build
	end

	def create
		@type = @camp.camp_application_types.create(type_params)

		respond_to do |format|
			if @type.save
				format.html {redirect_to camp_path(@camp)}
			else
				render :new
			end
		end
	end

	private
		def get_camp
			@camp = Camp.find(params[:camp_id])
		end

		def type_params
			params.require(:camp_application_type).permit(:kind)
		end
end
