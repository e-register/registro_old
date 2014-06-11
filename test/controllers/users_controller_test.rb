require 'test_helper'

class UsersControllerTest < ActionController::TestCase
	include UsersHelper

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
	    
	    info = get_user_info edoardo, edoardo
	    
	    assert_nil flash.now[:error]
	    assert_equal info, assigns(:user)
	end
	
	test "get other user info" do
		user = users(:user_elia)
		edoardo = users(:user_edoardo)
		
		get :user, { :id => user.id }, { :token => "a", :user_id => edoardo.id }
		
		info = get_user_info edoardo, user
		
		assert_nil flash.now[:error]
		assert_equal info, assigns(:user)
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
		assert_redirected_to me_path
	end
	
	test "update with an invalid user" do
		edoardo = users(:user_edoardo)
		
		put :update, { :id => "aa" }, { :token => "a", :user_id => edoardo.id }
		
		assert_equal "Identificativo non valido", flash.now[:error]
		assert_redirected_to root_path
	end
	
	test "update with valid parameters but unauthorized" do
		edoardo = users(:user_edoardo)
		
		p = {
			id: edoardo.id,
			user: {
				name: "Nome",
				surname: "Cognome"
			}
		}
		
		put :update, p, { :token => "a", :user_id => edoardo.id }
		
		assert_redirected_to me_path
		assert_equal "Accesso negato", flash[:error]
		
	end
	
	test "update with invaid parameters and unauthorized" do
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
		
		assert_redirected_to me_path
		assert_equal "Accesso negato", flash[:error]
		
	end
	
	test "update with invlid parameters authorized" do
		# skip this test on sqlite
		skip if ENV["DB"] == 'sqlite'
	
		admin = users(:user_admin)
		
		p = {
			id: admin.id,
			user: {
				name: "aa"*500,
				surname: "bb"*500
			}
		}
		
		put :update, p, { :token => "a", :user_id => admin.id }
		
		assert_equal "Impossibile salvare le informazioni", flash[:error]
		assert_redirected_to own_edit_path
	end
	
	test "update with valid parameters authorized" do
		admin = users(:user_admin)
		
		p = {
			id: admin.id,
			user: {
				name: "aa",
				surname: "bb"
			}
		}
		
		put :update, p, { :token => "a", :user_id => admin.id }
		
		assert_nil flash[:error]
		
		admin2 = User.find admin.id
		
		assert_equal "aa", admin2.name
		assert_equal "bb", admin2.surname
	end
	
	test "get the new user form" do
	    edoardo = users(:user_edoardo)
	    
	    get :new, nil, { :token => "a", :user_id => edoardo.id }
	    
	    assert_response :ok
	end
	
	test "create without the parameters" do
	    edoardo = users(:user_edoardo)
	    
	    post :create, {}, { :token => "a", :user_id => edoardo.id }
	    
	    assert_response :bad_request
	end
	
	test "create without only one parameter" do
	    edoardo = users(:user_edoardo)
	    
	    params = [ 'username', 'password', 'name', 'surname' ]
	    
	    params.each do |missing|
	        malformed = {}
	        params.each do |p|	        
	            malformed.merge!("#{p}" => rand(36**10).to_s(36)) if p != missing
	        end
	    
	        p = {
	            :user => malformed
	        }
	        
	        post :create, p, { :token => "a", :user_id => edoardo.id }
	        
	        assert_response :bad_request
	        assert_equal "Parametro #{missing} non specificato", flash.now[:error]
	    end
	end
	
	test "create user with error" do
    	# skip this test on sqlite
		skip if ENV["DB"] == 'sqlite'
		
	    edoardo = users(:user_edoardo)
	    
	    p = {
	        :user => {
	            :name => rand(36**1000).to_s(36),
	            :surname => rand(36**1000).to_s(36),
	            :username => rand(36**1000).to_s(36),
	            :password => rand(36**1000).to_s(36)
	        }
	    }
	    
	    post :create, p, { :token => "a", :user_id => edoardo.id }
	    
	    assert_redirected_to root_path
	    assert_equal "Impossibile creare l'utente", flash[:error]
	    
	end
	
	test "create user normally" do
	    edoardo = users(:user_edoardo)
	    
	    p = {
	        :user => {
	            :name => rand(36**10).to_s(36),
	            :surname => rand(36**10).to_s(36),
	            :username => rand(36**10).to_s(36),
	            :password => rand(36**10).to_s(36)
	        }
	    }
	    
	    post :create, p, { :token => "a", :user_id => edoardo.id }
	    
	    user = Credential.check username: p[:user][:username], password: p[:user][:password]
	    
	    assert_nil flash[:error]
	    assert_not_nil user
	    assert_redirected_to user_path user
	    assert_equal p[:user][:name], user.name
	    assert_equal p[:user][:surname], user.surname
	    
	end
end
