require 'base64'

# an access token
class Token < ActiveRecord::Base
	# a token is associated with an user
	belongs_to :user
	
	def self.generate_token
		SecureRandom.base64(128)
	end
end
