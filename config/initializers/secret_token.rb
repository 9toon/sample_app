# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
# SampleApp::Application.config.secret_key_base = '663be68332eb7a5cf5ac225c73cd196976a39f6e8a26c6564719ddebce2bd58d18a499703b57a7284e0ab4f7904eac95a81681935e1704cc947378ab652fd6a5'

require 'securerandom'

def secure_token
  token_file = Rails.root.join('.secret')
  if File.exist? (token_file)
    # Use the existing token.
    File.read(token_file).chomp
  else
    token = SecureRandom.hex(64)
    File.write(token_file, token)
    token
  end
end

SampleApp::Application.config.secret_key_base = secure_token
