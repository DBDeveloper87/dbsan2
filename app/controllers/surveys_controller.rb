class SurveysController < Channels::MyChannelController
	before_action :set_channel, only: [:index, :new]
	before_action :set_survey, only: [:edit, :show, :update]

	def index
		@surveys = @channel.surveys.all
		@subdomain = @channel.subdomain.slug
	end

	def new
		@survey = Survey.new
	end

	def edit
	end

	def show
	end

	def create
		@survey = Survey.create(create_params)
		channel_id = create_params[:channel_id]
		channel = Channel.find_by(id: channel_id)
		subdomain = channel.subdomain.slug

		if @survey.save
			redirect_to edit_survey_path(@survey, subdomain: subdomain)
		end
	end

	def update
		if @survey.update(update_params)
			redirect_to edit_survey_path(@survey, subdomain: @subdomain)
		end
	end

	private
		def create_params
			params.require(:survey).permit(:title, :channel_id)
		end

		def update_params
			params.require(:survey).permit(:description)
		end

		def set_survey
			@survey = Survey.find_by(id: params[:id])
			@channel = @survey.channel
			@subdomain = @channel.subdomain.slug
		end
end
