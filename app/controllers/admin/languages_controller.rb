class Admin::LanguagesController < Admin::AdminConsoleController
	before_action :set_language, only: :show

	def index
		@languages = Language.all
	end

	def new
		@language = Language.new
	end

	def show
	end

	def create
		@language = Language.create(language_params)

		if @language.save
			respond_to do |f|
				@languages = Language.all
				f.turbo_stream
			end
		end
	end

	private
		def language_params
			params.require(:language).permit(:name, :dialect, :short_code, :long_code, lang_type: [])
		end

		def set_language
			@language = Language.find(params[:id])
		end
	
end
