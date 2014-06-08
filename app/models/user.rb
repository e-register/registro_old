# the base information of a user
class User < ActiveRecord::Base
	# the gender of the user
	enum gender: [ :male, :female ]

	# a user can have more than one login account
	has_many :credentials
	# a user can have more token
	has_many :tokens

	# generate a new token for the user
	# Return the Token if success, otherwise nil
	def get_new_token
		token = Token.generate_token
		t = Token.new
		t.token = token
		t.user = self
		if t.save
			return t
		else 
			return nil
		end
	end

end
