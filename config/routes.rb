Rails.application.routes.draw do

	# TODO edit to get to the application controller
	root :to => 'evaluations#index'

	get '/evaluations' => 'evaluations#index', as: 'evaluations'
	
	get '/evaluations/class', to: redirect('/evaluations')
	get '/evaluations/class/:id' => 'evaluations#show_class'
	get '/evaluations/user/:id' => 'evaluations#show_user'
	
	get '/evaluations/:id/edit' => 'evaluations#edit', as: 'edit_evaluation'
	put '/evaluations/:id/edit' => 'evaluations#edit'
	patch '/evaluations/:id/edit' => 'evaluations#edit'
	
	delete '/evaluations/:id/delete' => 'evaluations#delete'
	
	get '/evaluations/new' => 'evaluations#new', as: 'new_evaluation'
	post '/evaluations/new' => 'evaluations#new'
	
	get '/evaluations/mult' => 'evaluations#mult'
	post '/evaluations/mult' => 'evaluations#mult'
		
	get '/evaluations/show' => 'evaluations#show'
	get '/evaluations/show/:id' => 'evaluations#show'
	get '/evaluations/:id' => 'evaluations#show', as: 'evaluation'

end
