require 'test_helper'

class UsersControllerTest < ActionController::TestCase
	test "valid login" do		
	    user = Credential.check username: "edoardo", password: "password"
	
		post :login, { :login => { :username => "edoardo", :password => "password" } }
		assert_not_nil assigns(:user)
		assert_not_nil session[:token]
		assert_not_nil session[:user_id]
		assert_equal user.id, session[:user_id]
		assert_equal "Login effettuato", flash.now[:info]
		
		assert_redirected_to root_path		
	end
	
	test "wrong login" do
		post :login, { :login => { :username => "edoardo", :password => "Password" } }
		assert_nil assigns(:user)
		assert_nil session[:token]
		assert_nil session[:user_id]
		assert_equal "Username/Password errati", flash.now[:error]
		
		assert_response :ok
	end
	
	test "already logged in" do
		post :login, 
			{ :login => { :username => "edoardo", :password => "password" } }, 
			{ :token => "a" }
			
		assert_redirected_to root_path
	end
	
	test "bad login, missing parameter" do
		post :login, {}
		assert_response :bad_request
		
		post :login, { :login => { :username => "edoardo" } }
		assert_response :bad_request
		
		post :login, { :login => { :password => "password" } }
		assert_response :bad_request
		
	end
	
	test "valid logout" do
		get :logout, nil, { :token => "a" }
		assert_redirected_to login_path
		assert_nil session[:token]
		assert_nil session[:user_id]
		assert_equal "Utente disconnesso", flash.now[:info]
	end
	
	test "invalid logout" do
		get :logout, nil, nil
		assert_redirected_to login_path
		assert_nil session[:token]
		assert_nil session[:user_id]
		assert_equal "L'utente non era connesso", flash[:warning]
	end
	
	test "get my user info" do
	    user = Credential.check username: "edoardo", password: "password"
	    get :user, nil, { :token => "a", :user_id => user.id }
	    
	    assert_nil flash.now[:error]
	    assert_equal user, assigns(:user)
	end
	
	test "get other user info" do
		user = Credential.check username: "elia", password: "password"
		edoardo = Credential.check username: "edoardo", password: "password"
		get :user, { :id => user.id }, { :token => "a", :user_id => edoardo.id }
		
		assert_nil flash.now[:error]
		assert_equal user, assigns(:user)
	end
	
	test "get an user that non exists" do
		edoardo = Credential.check username: "edoardo", password: "password"
		
		get :user, { :id => 1 }, { :token => "a", :user_id => edoardo.id }
		
		assert_equal "Utente non trovato", flash.now[:error]
		assert_nil assigns(:user)
	end
	
	test "get an invalid user id" do
		edoardo = Credential.check username: "edoardo", password: "password"
		
		get :user, { :id => "aaaa" }, { :token => "a", :user_id => edoardo.id }
		
		assert_equal "Identificativo non valido", flash[:error]
		assert_nil assigns(:user)
		assert_redirected_to root_path
	end
	
	test "get the edit form for myself" do
		edoardo = Credential.check username: "edoardo", password: "password"
		
		get :edit, nil, { :token => "a", :user_id => edoardo.id }
		
		assert_response :ok
		assert_equal edoardo, assigns(:user)
	end
	
	test "get the edit form for an other user" do
		edoardo = Credential.check username: "edoardo", password: "password"
		elia = Credential.check username: "elia", password: "password"
		
		get :edit, { :id => elia.id }, { :token => "a", :user_id => edoardo.id }
		
		assert_response :ok
		assert_equal elia, assigns(:user)
	end
	
end
