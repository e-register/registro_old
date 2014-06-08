class UsersController < ApplicationController

	def login		
		if get?
			# render...
		else
			# do login & redirect
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
