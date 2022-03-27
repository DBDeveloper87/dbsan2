class CampApplicationCeusController < ApplicationController
	before_action :authenticate_user!
	before_action :get_application, only: [:new, :create]

	def new
		@ceu = @application.build_camp_application_ceu
	end

	private
		def get_application
			@application = CampApplication.find(params[:id])
			@camp = @application.camp
		end

end
