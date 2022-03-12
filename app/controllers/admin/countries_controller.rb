class Admin::CountriesController < Admin::AdminConsoleController
	def index
		@countries = Country.all
	end

	def new
		@country = Country.new
	end

	def edit
		@country = Country.find(params[:id])
	end

	def show
		@country = Country.find(params[:id])
		@states = @country.state_provinces.all.order(:name)
	end

	def create
		@country = Country.new(country_params)

		respond_to do |format|
			if @country.save
				format.html {redirect_to admin_countries_path}
			else
				render :new
			end
		end
	end

	def update
		@country = Country.find(params[:id])

		if @country.update(country_params)
			redirect_to admin_countries_path
		end
	end
	

	private
		def country_params
			params.require(:country).permit(:name, :country_code, :unicode_flag)
		end
end
