# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.8' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Specify gems that this application depends on and have them installed with rake gems:install
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "sqlite3-ruby", :lib => "sqlite3"
  # config.gem "aws-s3", :lib => "aws/s3"
  config.gem "authlogic", :version => "2.1.6"
  config.gem "will_paginate", :version => '2.3.11'
  #config.gem "ambethia-recaptcha", :lib => "recaptcha/rails", :source => "http://gems.github.com", :version => '>= 0.2.2'
  config.gem "paperclip", :version => '2.3.1.1', :source => 'http://gemcutter.org'
  #config.gem "aasm", :version => '>= 2.1.3', :source => 'http://gemcutter.org'
  config.gem "searchlogic", :version => '2.4.27'
  config.gem "sanitize", :version => '1.2.1'
  #config.gem "forgery", :version => '>= 0.3.4'
  ##config.gem "delayed_job", :version => '>= 1.8.4'
  #config.gem "collectiveidea-delayed_job", :lib => 'delayed_job', :version => '>= 1.8.2', :source => 'http://gems.github.com'
  #config.gem 'hoptoad_notifier', :version => '>= 2.2.2'
  #config.gem "friendly_id", :version => "3.1.8"
  #config.gem "aasm", :version => ">= 2.1.5"

  #config.gem 'capistrano', :version => '>= 2.5.18'
  #
  ##config.gem 'daemons',  :version => '>= 1.0.10'
  #config.gem 'daemon-spawn', :version => '>= 0.2.0'
  #config.gem 'spreadsheet', :version => '>= 0.6.4.1'

  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Skip frameworks you're not going to use. To use Rails without a database,
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  #config.time_zone = 'UTC'
  config.time_zone = 'Istanbul'

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  # config.i18n.default_locale = :de
  config.i18n.default_locale = :tr
end

#Paperclip.options.merge!(:command_path => "/usr/bin")
#if `/usr/bin/which convert` == ""
#  raise "!!!!!!!!!!!!!!! convert bulunamadi! Paperclip icin gerekli.!!!!!!!!!!!" 
#end
