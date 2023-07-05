class SurveysController < ApplicationController
	before_action :authenticate_user!, only: [:new, :edit, :update, :create]
	before_action :set_channel, only: [:index, :new, :show, :edit, :update]
	before_action :set_survey, only: [:edit, :show, :update]
	layout "surveys"

	def index
		@meta_title = "Surveys | #{@channel.name}"
		@subdomain == request.subdomain
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
			elsif params[:part] == "survey_type"
				render partial: "surveys/basic_info/edit_survey_type", locals: {survey: @survey}
			elsif params[:part] == "short_description"
				render partial: "surveys/basic_info/edit_short_description", locals: {survey: @survey}
			elsif params[:part] == "long_description"
				render partial: "surveys/basic_info/edit_long_description", locals: {survey: @survey}
			end
		end
	end

	def show
		@meta_title = "#{@survey.title} | #{@channel.name}"
		@interviewers = []
		@survey.interviewers.each do |i|
			@interviewers.append(i.user.id)
		end
	end

	def create
		@survey = Survey.create(create_params)
		
		if @survey.save
			unless request.subdomain == "surveys"
				redirect_to survey_path(slug: @survey.slug, subdomain: request.subdomain)
			else
				redirect_to survey_subdomain_path(@survey.slug)
			end
		end
	end

	def update
		if @survey.update(update_params)
			redirect_to edit_survey_path(slug: @survey.slug)
		end
	end

	private
		def create_params
			params.require(:survey).permit(:title, :channel_id)
		end

		def update_params
			params.require(:survey).permit(:title, :slug, :description, :long_description, :survey_type)
		end

		def set_survey
			unless params[:slug] == "login"
				@survey = Survey.find_by(slug: params[:slug])
			end
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
				elsif request.domain == "dbsan.org"
					@channel = Subdomain.find_by(slug: request.subdomain).channel
				end
			end
		end
end
