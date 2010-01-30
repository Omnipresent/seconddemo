# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_420_application_session',
  :secret      => '6301d02c9b7ae1724dc7088e5d0814c6afc9590c8417fbfdbffcacd64bae5d2be453abeb3c926df8efa16570c0d3276e13ce13e4b38103e525cd1fb9d89d5418'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
