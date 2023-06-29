# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  layout "authentication", only: :new

  # GET /resource/sign_up
  def new
    @subdomain = Subdomain.find_by(slug: request.subdomain)
    @channels = Channel.all
    domains = []
    @channels.each do |c|
      domains.append(c.domain_host)
    end
    domains = domains.uniq

    if request.domain == "dbsan.org" or request.domain == "example.com"
      @channel = @subdomain.channel
    elsif request.domain.in?(domains)
      @channel = Channel.find_by(domain_host: request.domain)
    end
    
    @meta_title = "Create Account"
    super
  end

  # POST /resource
  def create
    @subdomain = Subdomain.find_by(slug: request.subdomain)
    @channels = Channel.all
    domains = []
    @channels.each do |c|
      domains.append(c.domain_host)
    end
    domains = domains.uniq

    if request.domain == "dbsan.org" or request.domain == "example.com"
      @channel = @subdomain.channel
    elsif request.domain.in?(domains)
      @channel = Channel.find_by(domain_host: request.domain)
    end
    
    super
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
     devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute, 
      channel_members_attributes: [:id, :channel_id, :user_id],
      profile_attributes: [:first_name, :last_name]])
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
