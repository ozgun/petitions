# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_dilekceler_session',
  :secret      => '91c8551208ddbc395941f444b844afcbb846c00a64d0e0145fc65ac88409bf9e64ddc62470934e3ba8eb3535fba893d482a671cd10a7c29dbf092aaee3d757aa'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
#ActionController::Base.session_store = :active_record_store
