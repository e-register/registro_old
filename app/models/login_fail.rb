# the information about a login failture
class LoginFail < ActiveRecord::Base
	def self.bad_password ip, options = {}
		l = LoginFail.new
		l.username = options[:username]
		l.ip = ip
		return l.save
	end
end
