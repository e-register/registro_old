module EvaluationsHelper
	include AccessHelper

	SHOW_TABLE = {
		# myself means the teacher and the student who own the evaluation
		visible: ACCESS_ADMIN | ACCESS_COORD | ACCESS_MYSELF
	}

	EDIT_TABLE = {
		
	}

	# check if the user can view the evaluation, according to the SHOW_TABLE
	def can_show? me, eval
		table = SHOW_TABLE
		level = get_user_level me, eval

		return level & table[:visible] > 0
	end

	# check witch of a series of evaluations can be viewed
	def can_show_multiple me, evals
		fast_can_show_multiple me, evals
	end

	# DEPRECATED! the fast version is always faster than this one
	#def slow_can_show_multiple me, evals
	#	table = SHOW_TABLE
	#	# skip all test if the user is an admin
	#	return evals if me.admin? and table[:visible] & ACCESS_ADMIN > 0
	#
	#	visible = []
	#
	#	evals.each { |e| visible << e if can_show? me, e }
	#
	#	return visible
	#end

	def fast_can_show_multiple me, evals
		table = SHOW_TABLE
		# skip all test if the user is an admin
		return evals if me.admin? and table[:visible] & ACCESS_ADMIN > 0

		# if teacher => check the class admin
		# check the same class

		# hash because the keys may not be only low integers
		user_classes = {}
		visible = []
		evals.each do |e|
			level = ACCESS_ANYONE
			level |= ACCESS_COORD if me.teacher? and is_admin? me.id, e.student_id, user_classes
			level |= ACCESS_TEACH if me.teacher? and same_class? me.id, e.student_id, user_classes
			level |= ACCESS_STUD if me.student? and same_class? e.teacher_id, me.id, user_classes
			level |= ACCESS_MYSELF if me.id == e.teacher_id or me.id == e.student_id

			visible << e if table[:visible] & level > 0
		end
		return visible
	end

	def load_classes id_user, teacher
		classes = []
		if teacher
			classes = Teacher.select("class_info_id, (SELECT admin_id FROM class_infos WHERE id=class_info_id) AS admin_id").where(teacher_id: id_user).map{ |c| { id: c.class_info_id, admin: c.admin_id } }.uniq
		else
			classes = Student.select("class_info_id, (SELECT admin_id FROM class_infos WHERE id=class_info_id) AS admin_id").where(student_id: id_user).map{ |c| { id: c.class_info_id, admin: c.admin_id } }.uniq
		end
		return classes
	end
	def same_class? id_teacher, id_student, user_classes
		user_classes[id_teacher] = load_classes(id_teacher, true) if user_classes[id_teacher].nil?
		user_classes[id_student] = load_classes(id_student, false) if user_classes[id_student].nil?

		return (user_classes[id_teacher] & user_classes[id_student]).length > 0
	end
	def is_admin? id_teacher, id_student, user_classes
		user_classes[id_teacher] = load_classes(id_teacher, true) if user_classes[id_teacher].nil?
		user_classes[id_student] = load_classes(id_student, false) if user_classes[id_student].nil?

		found = false
		user_classes[id_student].each { |c| found = true if c[:admin] == id_teacher }
		return found
	end

	# =============
	    protected
	# =============

	# get the level of the user about the evaluation
	def get_user_level me, eval
		# this will load:
		# if me.teacher?
		# 	- the student of the evaluation
		# 		- the classes of the user (teacher or student)
		# 		- the admin of each class
		# if me.student?
		#	- the student of the evaluation
		#		- the classes of the user
		#		- the classes of the student

		level = ACCESS_ANYONE
		# school administrator
		level |= ACCESS_ADMIN if me.admin?
		# class administrator
		level |= ACCESS_COORD if me.teacher? and eval.student.admins.include? me
		# class teacher
		level |= ACCESS_TEACH if me.teacher? and eval.student.same_class? me
		# class student
		level |= ACCESS_STUD if me.student? and eval.student.same_class? me
		# the student or the teacher
		level |= ACCESS_MYSELF if me == eval.student or me == eval.teacher

		return level
	end
end
