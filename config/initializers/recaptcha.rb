Recaptcha.configure do |config|
  config.site_key  = Rails.application.credentials.recaptcha[:SITE_KEY]
  config.secret_key = Rails.application.credentials.recaptcha[:SECRET_KEY]
end