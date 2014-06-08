class UsersController < ApplicationController
	
	# the login form & the login action
	def login
		# if the user is alread logged in, redirect him somewhere
		if session[:token]
			redirect_to root_path
		end
		# if the request is the form, show it!
		if request.get?
			# render...
		# if the request is a login from username & password
		elsif request.post?
			# check the username and the password presence
			if params[:login][:username] && params[:login][:password]
				# check if they are correct
				user = Credential.check params[:login]
				unless user
					flash[:error] = "Username/Password errati"
				else
					# login the user and generate a new token
					token = user.get_new_token
					session[:token] = token
					flash[:error] = "Login effettuato"
				end
			else
				head :bad_request
			end
		end
	end
	
	def logout
		# logout
	end
	
	def user
		# more complicated stuff...
	end
	
	def edit
		# show the edit form
	end
	
	def update
		# update the user
	end
	
	def new
		# show the new-user-form
	end
	
	def create
		# create the user & redirect
	end
end
