require 'test_helper'

class EvaluationsControllerTest < ActionController::TestCase
	test "show with valid id" do
		e = Evaluation.all.first
	
		get :show, { 'id' => e.id }
		assert_response :success
		assert_not_nil assigns(:evaluation)
		assert_equal e, assigns(:evaluation)
		assert_nil flash[:error]
	end
	
	test "show without id" do
		get :show
		assert_response :ok
	end
	
	test "show with malformed id" do
		get :show, { 'id' => "a" }		
		assert_response :found
		assert_redirected_to root_path
		
		get :show, { 'id' => "" }
		assert_response :found
		assert_redirected_to root_path
	end
end
