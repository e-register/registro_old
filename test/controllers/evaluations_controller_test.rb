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
		get :show
		assert_response :ok
	end
	
	test "show with malformed id" do
		get :show, { 'id' => "a" }
		assert_redirected_to root_path
		
		get :show, { 'id' => "" }
		assert_redirected_to root_path
	end
end
