Rails.application.routes.draw do

	root :to => 'pages#index'

	# ---------------
	#   EVALUATIONS
	# ---------------
	
	get '/evaluations' => 'evaluations#index', as: 'eval_index'
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
	
	get '/user/:id/edit' => 'users#edit', as: 'edit'
	get '/user/edit' => 'users#edit', as: 'own_edit'
	put '/user/edit' => 'users#update'
	put '/user/:id/edit' => 'users#update'
	patch '/user/edit' => 'users#update'
	patch '/user/:id/edit' => 'users#update'
	
	get '/user/edit/:id' => 'users#edit'
	put '/user/edit/:id' => 'users#update'
	patch '/user/edit/:id' => 'users#update'
	
	get '/user/new' => 'users#new', as: 'new_user'
	post '/user/new' => 'users#create'

	# last because /user/:id overrides the other options	
	get '/user/user/:id' => 'users#user'
	get '/user/:id' => 'users#user', as: 'user'
	get '/user' => 'users#user', as: 'me'

end
