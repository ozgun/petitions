# Settings specified here will take precedence over those in config/environment.rb

# The production environment is meant for finished, "live" apps.
# Code is not reloaded between requests
config.cache_classes = true

# Full error reports are disabled and caching is turned on
config.action_controller.consider_all_requests_local = false
config.action_controller.perform_caching             = true
config.action_view.cache_template_loading            = true

# See everything in the log (default is :info)
# config.log_level = :debug

# Use a different logger for distributed setups
# config.logger = SyslogLogger.new

# Use a different cache store in production
# config.cache_store = :mem_cache_store

# Enable serving of images, stylesheets, and javascripts from an asset server
# config.action_controller.asset_host = "http://assets.example.com"

# Disable delivery errors, bad email addresses will be ignored
# config.action_mailer.raise_delivery_errors = false

# Enable threaded mode
# config.threadsafe!

# script
SMTP_USER = "test@example.com"
SMTP_PASS = "123456"
SMTP_SERVER = "smtp.gmail.com"
SMTP_EMAIL_DOMAIN = "example.com"

# Mail server settings
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :enable_starttls_auto => true,
  :port => 587,
  :address => SMTP_SERVER,
  :user_name => SMTP_USER,
  :password => SMTP_PASS,
  :domain => SMTP_EMAIL_DOMAIN,
  :authentication => :plain
}

# Enable threaded mode
# config.threadsafe!

# This is used in mailers
DEFAULT_DOMAIN = "example.com"
DEFAULT_HOST = DEFAULT_DOMAIN
