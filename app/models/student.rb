# this makes a user member of a class as student
class Student < ActiveRecord::Base
	# the user reference of the student
	belongs_to :student, class_name: 'User', foreign_key: 'student_id'
	# the class of the student
	belongs_to :class_info
end
