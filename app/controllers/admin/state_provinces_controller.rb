class Admin::StateProvincesController < Admin::AdminConsoleController
	before_action :get_country, only: [:new, :create]

	

	def new
		@state = @country.state_provinces.build
	end

	def create
		@state = @country.state_provinces.create(state_params)

		respond_to do |format|
			if @state.save
				format.html { redirect_to admin_country_path(@country)}
			else
				render :new
			end
		end
	end

	private
		def get_country
			@country = Country.find(params[:country_id])
		end

		def state_params
			params.require(:state_province).permit(:unicode_flag, :code, :name)
		end
end
