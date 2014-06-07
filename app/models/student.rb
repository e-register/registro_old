# this makes a user member of a class as student
class Student < ActiveRecord::Base
	# the user reference of the student
	belongs_to :users
	# the class of the student
	belongs_to :class_infos
end
