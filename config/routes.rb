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
	get '/user/logout' => 'users#logout', as: 'logout'
	
	get '/user/user/:id' => 'users#user'
	get '/user/:id' => 'users#user'
	get '/user' => 'users#user', as: 'user'
	
	get '/user/edit' => 'users#edit', as: 'edit'
	put '/user/edit' => 'users#update'
	patch '/user/edit' => 'users#update'
	
	get '/user/edit/:id' => 'users#edit'
	put '/user/edit/:id' => 'users#update'
	patch '/user/edit/:id' => 'users#update'
	
	get '/user/new' => 'users#new', as: 'new_user'
	post '/user/new' => 'users#create'

end
