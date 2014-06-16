require 'test_helper'

class EvaluationsHelperTest < ActionView::TestCase
	include EvaluationsHelper

	test "can show" do
		edoardo = users(:user_edoardo)
		e = evaluations(:eval_1)
		
		assert can_show? edoardo, e
	end	
	
	test "can not show" do
		edoardo = users(:user_edoardo)
		e = evaluations(:eval_2)
		
		assert_not can_show? edoardo, e
	end	
	
	test "can show multiple" do
		edoardo = users(:user_edoardo)
		e1 = evaluations(:eval_1)
		e2 = evaluations(:eval_2)
		
		aspected = [ e1 ]
		
		assert_equal aspected, can_show_multiple(edoardo, [ e1, e2 ])
	end
end
