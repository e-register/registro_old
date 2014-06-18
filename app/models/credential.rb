# the association username-password with some other details
class Credential < ActiveRecord::Base
	include PasswordHash

	# a credential is associated with only one user
	belongs_to :user
	
	validate :username, presence: true, uniqueness: true
	validate :password, presence: true
	validate :user_id, presence: true
	
	# check if the username and the password are valid
	# return a User if the login is correct, nil otherwise
	def self.check options = {}
		begin
			# search for a credential with the exact username
			credential = Credential.where(username: options[:username]).first
			return nil if !credential
			
			# if the password hash is valid	
			if PasswordHash.validatePassword(options[:password], credential.password)
				return credential.user
			else
				return nil
			end
		end
	end
		
	def self.generate options = {}
		c = Credential.new options
		c.password = PasswordHash.createHash options[:password]
		c.save!
	end
end
