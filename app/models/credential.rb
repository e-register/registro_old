# the association username-password with some other details
class Credential < ActiveRecord::Base
	# a credential is associated with only one user
	belongs_to :users
	
	def check username, password
		begin
			credential = Credential.where(username: username)
			return nil if !credential
			# TODO check password
			if validatePassword(password, self.password)
				return credential.user 
			else
				return nil
			end
		rescue
			return nil
		end
	end
end
