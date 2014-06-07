# the association username-password with some other details
class Credential < ActiveRecord::Base
	# a credential is associated with only one user
	belongs_to: :users
end
