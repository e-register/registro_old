# the association username-password with some other details
class Credential < ActiveRecord::Base
	include PasswordHash

	# a credential is associated with only one user
	belongs_to :user
	
	# check if the username and the password are valid
	# return a User if the login is correct, nil otherwise
	def self.check username, password
		begin
			# search for a credential with the exact username
			credential = Credential.where(username: username).first
			return nil if !credential
			
			# if the password hash is valid	
			if PasswordHash.validatePassword(password, credential.password)
				return credential.user
			else
				return nil
			end
		rescue 
			return nil
		end
	end
end
