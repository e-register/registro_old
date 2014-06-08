# this makes an user a teacher of a subject in a class
class Teacher < ActiveRecord::Base
	# the reference to the user
	belongs_to :teacher, class_name: 'User', foreign_key: 'teacher_id'
	# the subject teached in the class
	belongs_to :subject
	# the class where the teacher teach
	belongs_to :class_info
end
