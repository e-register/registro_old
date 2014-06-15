require 'test_helper'

class EvaluationsControllerTest < ActionController::TestCase
	test "show with valid id" do
		e = evaluations(:eval_1)
		edoardo = users(:user_edoardo)
	
		get :show, { 'id' => e.id }, { token: "a", user_id: edoardo.id }
		assert_response :success
		assert_not_nil assigns(:evaluation)
		assert_equal e, assigns(:evaluation)
		assert_nil flash[:error]
	end
	
	test "show unauthorized" do
		e = evaluations(:eval_2)
		edoardo = users(:user_edoardo)
	
		get :show, { 'id' => e.id }, { token: "a", user_id: edoardo.id }
		assert_redirected_to eval_index_path
		assert_equal "Accesso negato", flash[:error]
	end
	
	test "show without id" do
		edoardo = users(:user_edoardo)
		
		get :show, {}, { token: "a", user_id: edoardo.id }
		assert_response :ok
	end
	
	test "show with malformed id" do
		edoardo = users(:user_edoardo)
		
		get :show, { 'id' => "a" }, { token: "a", user_id: edoardo.id }
		assert_redirected_to root_path
		
		get :show, { 'id' => "" }, { token: "a", user_id: edoardo.id }
		assert_redirected_to root_path
	end
	
	test "show not logged in" do
		e = evaluations(:eval_2)
	
		get :show, { 'id' => e.id }, {}
		assert_redirected_to login_path
	end
	
	test "get class with valid id" do
		edoardo = users(:user_edoardo)
		c = class_infos(:class_1)
		
		e1 = evaluations(:eval_1)
		e2 = evaluations(:eval_2)
		
		get :show_class, { id: c.id }, { token: "a", user_id: edoardo.id }
		
		e = assigns(:evaluations)
		
		assert_nil flash[:error]
		assert_response :ok
		
		assert_not_nil e
		assert_equal 2, e.length
		assert e.include? e1
		assert e.include? e2
	end
	
	test "get class with invalid id" do
		edoardo = users(:user_edoardo)
		
		get :show_class, { id: 1 }, { token: "a", user_id: edoardo.id }
		
		assert_equal "Classe non trovata", flash[:error]
		assert_redirected_to eval_index_path
	end
	
	test "get user with valid id" do
		edoardo = users(:user_edoardo)
		
		e1 = evaluations(:eval_1)
		
		get :show_user, { id: edoardo.id }, { token: "a", user_id: edoardo.id }
		
		e = assigns(:evaluations)
		
		assert_nil flash[:error]
		assert_response :ok
		
		assert_equal [ e1 ], e
	end
	
	test "get user with invalid id" do
		edoardo = users(:user_edoardo)
		
		get :show_user, { id: 1 }, { token: "a", user_id: edoardo.id }
		
		assert_equal "Utente non trovato", flash[:error]
		assert_redirected_to eval_index_path
	end
end
