# Settings specified here will take precedence over those in config/environment.rb

# In the development environment your application's code is reloaded on
# every request.  This slows down response time but is perfect for development
# since you don't have to restart the webserver when you make code changes.
config.cache_classes = false

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_view.debug_rjs                         = true
config.action_controller.perform_caching             = false

# Don't care if the mailer can't send
config.action_mailer.raise_delivery_errors = false

# SMTP Server credentials, we need these even we don't send emails to the real world.
SMTP_USER = "test@example.com"
SMTP_PASS = "secret"
SMTP_SERVER = "localhost"
SMTP_EMAIL_DOMAIN = "localhost.loc"

# This is used in mailers
DEFAULT_DOMAIN = "localhost"
DEFAULT_HOST = "#{DEFAULT_DOMAIN}:3000"
