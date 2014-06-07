# this makes an user a teacher of a subject in a class
class Teacher < ActiveRecord::Base
	# the reference to the user
	belongs_to :users
	# the subject teached in the class
	belongs_to :subjects
	# the class where the teacher teach
	belongs_to :class_infos
end
