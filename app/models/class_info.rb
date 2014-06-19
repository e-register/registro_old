# this contains the informations about a class
class ClassInfo < ActiveRecord::Base
	# a class has an administrator (which is an user)
	belongs_to :admin, :class_name => User

	# get a list of the students in the class
	def get_students(sort = false)
		if sort
			return Student.where(class_info: self) \
				.order("(SELECT surname FROM users WHERE id = student_id), \
				(SELECT name FROM users WHERE id = student_id)").to_a.uniq
		else
			return Student.where(class_info: self).to_a.uniq
		end
	end

	# get a list of the teachers in the class
	def get_teachers(sort = false)
		if sort
			return Teacher.where(class_info: self) \
				.order("(SELECT surname FROM users WHERE id = teacher_id), \
				(SELECT name FROM users WHERE id = teacher_id)").to_a.uniq
		else
			return Teacher.where(class_info: self).to_a.uniq
		end
	end
end
