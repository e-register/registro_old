require 'test_helper'

class EvaluationTest < ActiveSupport::TestCase
	test "All information corrrect for Evaluation" do
		teacher = Credential.check username: "prof", password: "password"
		student = Credential.check username: "edoardo", password: "password"
		date = "2014-06-08"
		score = Score.where(value: 8).first
		subject = Subject.where(name: "Matematica").first
		class_test = ClassTest.where(description: "Compito sugli integrali").first		
		
		v = Evaluation.where(description: "valutazione 1").first
		
		assert_not_nil v
		
		assert_equal teacher, v.teacher
		assert_equal student, v.student
		assert_equal Date.parse(date), v.date
		assert_equal score, v.score
		assert_equal subject, v.subject
		assert_equal "oral", v.evaluation_type
		assert_equal "valutazione 1", v.description
		assert_equal class_test, v.class_test
	end
end
