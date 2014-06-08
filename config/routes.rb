Rails.application.routes.draw do

  root :to => 'evaluations#index'

	get '/evaluations' => 'evaluations#index'
	get '/evaluations/show' => 'evaluations#show'
	get '/evaluations/show/:id' => 'evaluations#show'
	get '/evaluations/:id' => 'evaluations#show'
	
	get '/evaluations/class/:id' => 'evaluations#show_class'
	get '/evaluations/user/:id' => 'evaluations#show_user'
	
	get '/evaluations/:id/edit' => 'evaluations#edit'
	put '/evaluations/:id/edit' => 'evaluations#edit'
	patch '/evaluations/:id/edit' => 'evaluations#edit'
	
	delete '/evaluations/:id/delete' => 'evaluations#delete'
	
	get '/evaluations/new' => 'evaluations#new'
	post '/evaluations/new' => 'evaluations#new'
	
	get '/evaluations/mult' => 'evaluations#mult'
	post '/evaluations/mult' => 'evaluations#mult'

end
