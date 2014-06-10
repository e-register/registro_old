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
	    
	end
	
end
