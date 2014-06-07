# an access token
class Token < ActiveRecord::Base
	# a token is associated with an user
	belongs_to :users
end
