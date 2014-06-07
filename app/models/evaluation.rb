# this contains the informations about an evaluation
class Evaluation < ActiveRecord::Base
	# link to the teacher who created the evaluation
	belongs_to :teacher, :class_name => User
	# link to the student who own the evaluation
	belongs_to :student, :class_name => User
	# the subject of the evaluation
	belongs_to :subjects
	# the score of the evaluation
	belongs_to :scores
	# the evaluation may be in a class test group
	belongs_to :class_tests
end
