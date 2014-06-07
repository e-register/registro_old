# the base information of a user
class User < ActiveRecord::Base
	# a user can have more than one login account
	has_many: :credentials

end
