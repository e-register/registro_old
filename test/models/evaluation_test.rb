require 'test_helper'

class EvaluationTest < ActiveSupport::TestCase
	test "All information corrrect for Evaluation" do
		teacher = users(:user_prof)
		student = users(:user_edoardo)
		
		e = evaluations(:eval_1)		
		v = Evaluation.where(description: "valutazione 1").first
		
		assert_not_nil v
		
		assert_equal e.teacher, v.teacher
		assert_equal e.student, v.student
		assert_equal e.date, v.date
		assert_equal e.score, v.score
		assert_equal e.subject, v.subject
		assert_equal e.evaluation_type, v.evaluation_type
		assert_equal e.description, v.description
		assert_equal e.class_test, v.class_test
	end
end
