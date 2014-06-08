# the base information of a user
class User < ActiveRecord::Base
	# the gender of the user
	enum gender: [ :male, :female ]

	# a user can have more than one login account
	has_many :credentials
	# a user can have more token
	has_many :tokens

end
