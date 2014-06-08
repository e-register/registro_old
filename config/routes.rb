Rails.application.routes.draw do

	# TODO edit to get to the application controller
	root :to => 'evaluations#index'

	# ---------------
	#   EVALUATIONS
	# ---------------
	resource :evaluations
	
	get '/evaluations/class/:id' => 'evaluations#show_class'
	get '/evaluations/user/:id' => 'evaluations#show_user'
	get '/evaluation/:id/edit' => 'evaluations#edit'
	get '/evaluation/:id' => 'evaluations#show'
	
	
	# ---------------
	#   USERS
	# ---------------	
	get '/user/login' => 'users#login', as: 'login'
	post '/user/login' => 'users#login'
	post '/user/logout' => 'users#logout', as: 'logout'
	
	get '/user/user/:id' => 'users#user'
	get '/user/:id' => 'user#user', as: 'user'
	
	get '/user/edit' => 'user#edit', as: 'edit'
	put '/user/edit' => 'user#update'
	patch '/user/edit' => 'user#update'
	
	get '/user/edit/:id' => 'user#edit'
	put '/user/edit/:id' => 'user#update'
	patch '/user/edit/:id' => 'user#update'
	
	get '/user/new' => 'user#new', as: 'new_user'
	post '/user/new' => 'user#create'

end
