require 'test_helper'

class UsersControllerTest < ActionController::TestCase
	test "valid login" do		
	    edoardo = users(:user_edoardo)
	
		post :login, { :login => { :username => "edoardo", :password => "password" } }
		assert_not_nil assigns(:user)
		assert_not_nil session[:token]
		assert_not_nil session[:user_id]
		assert_equal edoardo.id, session[:user_id]
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
	    edoardo = users(:user_edoardo)
	    
	    get :user, nil, { :token => "a", :user_id => edoardo.id }
	    
	    assert_nil flash.now[:error]
	    assert_equal edoardo, assigns(:user)
	end
	
	test "get other user info" do
		user = users(:user_elia)
		edoardo = users(:user_edoardo)
		
		get :user, { :id => user.id }, { :token => "a", :user_id => edoardo.id }
		
		assert_nil flash.now[:error]
		assert_equal user, assigns(:user)
	end
	
	test "get an user that non exists" do
		edoardo = users(:user_edoardo)
		
		get :user, { :id => 1 }, { :token => "a", :user_id => edoardo.id }
		
		assert_equal "Utente non trovato", flash.now[:error]
		assert_nil assigns(:user)
	end
	
	test "get an invalid user id" do
		edoardo = users(:user_edoardo)
		
		get :user, { :id => "aaaa" }, { :token => "a", :user_id => edoardo.id }
		
		assert_equal "Identificativo non valido", flash[:error]
		assert_nil assigns(:user)
		assert_redirected_to root_path
	end
	
	test "get the edit form for myself" do
		edoardo = users(:user_edoardo)
		
		get :edit, nil, { :token => "a", :user_id => edoardo.id }
		
		assert_response :ok
		assert_equal edoardo, assigns(:user)
	end
	
	test "get the edit form for an other user" do
		edoardo = users(:user_edoardo)
		elia = users(:user_elia)
		
		get :edit, { :id => elia.id }, { :token => "a", :user_id => edoardo.id }
		
		assert_response :ok
		assert_equal elia, assigns(:user)
	end
	
	test "get the edit form for a not existing user" do
		edoardo = users(:user_edoardo)
		
		get :edit, { :id => 1 }, { :token => "a", :user_id => edoardo.id }
		
		assert_equal "Utente non trovato", flash.now[:error]
		assert_nil assigns(:user)
	end
	
	test "get the edit form for an invalid user" do
		edoardo = users(:user_edoardo)
		
		get :edit, { :id => "aaa" }, { :token => "a", :user_id => edoardo.id }
		
		assert_equal "Identificativo non valido", flash.now[:error]
		assert_nil assigns(:user)
		assert_redirected_to root_path
	end
	
	test "update without the user" do
		edoardo = users(:user_edoardo)
		
		put :update, nil, { :token => "a", :user_id => edoardo.id }
		
		assert_response :bad_request
	end
	
	test "update with a not existing user" do
		edoardo = users(:user_edoardo)
		
		p = {
			:id => 1,
			:user => {}
		}
		
		put :update, p, { :token => "a", :user_id => edoardo.id }
		
		assert_equal "Utente non trovato", flash.now[:error]
		assert_redirected_to user_path
	end
	
	test "update with an invalid user" do
		edoardo = users(:user_edoardo)
		
		put :update, { :id => "aa" }, { :token => "a", :user_id => edoardo.id }
		
		assert_equal "Identificativo non valido", flash.now[:error]
		assert_redirected_to root_path
	end
	
	test "update with valid parameters" do
		edoardo = users(:user_edoardo)
		
		p = {
			id: edoardo.id,
			user: {
				name: "Nome",
				surname: "Cognome"
			}
		}
		
		put :update, p, { :token => "a", :user_id => edoardo.id }
		
		edo2 = User.find edoardo.id
		
		assert_not_nil edo2
		assert_equal "Nome", edo2.name
		assert_equal "Cognome", edo2.surname
		
	end
	
	test "update myself with invaid parameters" do
		# skip this test on sqlite
		skip if ENV["DB"] == 'sqlite'
	
		edoardo = users(:user_edoardo)
		
		p = {
			id: edoardo.id,
			user: {
				name: "aa"*500,
				surname: "bb"*500
			}
		}
		
		put :update, p, { :token => "a", :user_id => edoardo.id }
		
		assert_equal "Impossibile salvare le informazioni", flash[:error]
		assert_redirected_to own_edit_path		
	end
	test "update with invaid parameters" do
		# skip this test on sqlite
		skip if ENV["DB"] == 'sqlite'
	
		elia = users(:user_elia)
		edoardo = users(:user_edoardo)
		
		p = {
			id: elia.id,
			user: {
				name: "aa"*500,
				surname: "bb"*500
			}
		}
		
		put :update, p, { :token => "a", :user_id => edoardo.id }
		
		assert_equal "Impossibile salvare le informazioni", flash[:error]
		assert_redirected_to edit_path elia
	end
	
	test "get the new user form" do
	    edoardo = users(:user_edoardo)
	    
	    get :new, nil, { :token => "a", :user_id => edoardo.id }
	    
	    assert_response :ok
	end
end
