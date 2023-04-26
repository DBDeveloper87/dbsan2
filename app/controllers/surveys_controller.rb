class SurveysController < ApplicationController
	before_action :authenticate_user!, only: [:new, :edit, :update, :create]
	before_action :set_channel, only: [:index, :new, :show, :edit]
	before_action :set_survey, only: [:edit, :show, :update]
	layout "surveys"

	def index
		@surveys = @channel.surveys.all
	end

	def new
		@survey = Survey.new
	end

	def edit
		if params[:part].present?
			if params[:part] == "title"
				render partial: "surveys/basic_info/edit_title", locals: {survey: @survey}
			elsif params[:part] == "slug"
				render partial: "surveys/basic_info/edit_slug", locals: {survey: @survey}
			end
		end
	end

	def show
	end

	def create
		@survey = Survey.create(create_params)
		channel_id = create_params[:channel_id]
		channel = Channel.find_by(id: channel_id)
		subdomain = channel.subdomain.slug

		if @survey.save
			redirect_to edit_survey_path(@survey.slug)
		end
	end

	def update
		if @survey.update(update_params)
			redirect_to edit_survey_path(@survey.slug)
		end
	end

	private
		def create_params
			params.require(:survey).permit(:title, :channel_id)
		end

		def update_params
			params.require(:survey).permit(:title, :slug, :description)
		end

		def set_survey
			@survey = Survey.find_by(slug: params[:slug])
			@channel = @survey.channel
			#@subdomain = @channel.subdomain.slug
		end

		def set_channel
			if Rails.env == "development"
				if request.subdomain == "surveys"
					@channel = Channel.find_by(name: "DeafBlind Support and Access Network")
				else
					@channel = Subdomain.find_by(slug: request.subdomain).channel
				end
			elsif Rails.env == "production"
				if request.subdomain == "surveys" and request.domain == "dbsan.org"
					@channel = Channel.find_by(name: "DeafBlind Support and Access Network")
				elsif request.subdomain == "surveys"
					@channel = Channel.find_by(domain_host: request.domain)
				else
					@channel = Subdomain.find_by(slug: request.subdomain).channel
				end
			end
		end
end
