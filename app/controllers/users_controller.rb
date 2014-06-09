class UsersController < ApplicationController
	
	before_filter :need_login, :only => [ :user, :edit, :update, :new, :create ]
	before_filter :validate_id, :only => [ :user, :edit, :update ]
	
	# the login form & the login action
	def login
		# if the user is alread logged in, redirect him somewhere
		if session[:token]
			redirect_to root_path
			return
		end
		# if the request is the form, show it!
		if request.get?
			# render...
		# if the request is a login from username & password
		elsif request.post?
			# check the username and the password presence
			if params[:login] && params[:login][:username] && params[:login][:password]
				# check if they are correct
				@user = Credential.check params[:login]
				unless @user
					flash[:error] = "Username/Password errati"
					LoginFail.bad_password request.remote_ip, params[:login]
				else
					# login the user and generate a new token
					token = @user.get_new_token
					session[:token] = token
					flash[:info] = "Login effettuato"
					redirect_to root_path
				end
			else
				head :bad_request
			end
		end
	end
	
	def logout
		# if the user wasn't logged it
		unless session[:token]
			flash[:warning] = "L'utente non era connesso"
			redirect_to login_path
		else
			session[:token] = nil
			flash[:info] = "Utente disconnesso"
			redirect_to login_path
		end
	end
	
	def user
		
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
	
	# ==================
	#     PROTECTED
	# ==================
	protected
	
	# check if the user is logged in
	def need_login
		redirect_to login_path unless session[:token]
	end
	
	# check if the id parameter is valid
	def validate_id
		unless params[:id] && params[:id].to_i > 0
			flash[:error] = "Identificativo non valido"
			redirect_to root_path
		end
	end
end
